import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/services/editService.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordconfirmController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final EditService _editService = EditService();
  bool _isLoading = false;
  bool _isHovering = false;
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<AllProvider>(context, listen: false);
    _nameController.text = userProvider.name ?? 'Nome do Usuário';
    _emailController.text = userProvider.email ?? 'Email do Usuário';
    _passwordController.text = '********';
    _passwordconfirmController.text = '';
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      html.File? file = await _pickFile();
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((e) {
          final imageBytes = reader.result as Uint8List?;
          Provider.of<ProfileImageProvider>(context, listen: false)
              .setImageBytes(imageBytes);
          _uploadImage(imageBytes!);
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        Provider.of<ProfileImageProvider>(context, listen: false)
            .setImageBytes(bytes);
        await _uploadImage(bytes);
      }
    }
  }

  Future<html.File?> _pickFile() async {
    final completer = Completer<html.File?>();
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isEmpty) {
        completer.complete(null);
      } else {
        completer.complete(files[0]);
      }
    });

    return completer.future;
  }

  Future<void> _uploadImage(Uint8List imageBytes) async {
    setState(() {
      _isLoading = true;
    });

    const String baseUrl = 'http://127.0.0.1:8000/api';

    try {
      final profileProvider = Provider.of<AllProvider>(context, listen: false);
      final token = profileProvider.token;

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/profileupd'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(http.MultipartFile.fromBytes(
        'profile_image',
        imageBytes,
        filename: 'profile_image.jpg',
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        await profileProvider.fetchUserProfile();
      } else {
        throw Exception(
            'Erro ao atualizar a imagem de perfil: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _editName() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<AllProvider>(context, listen: false);
      final token = userProvider.token;
      final id = userProvider.userId;
      final old = _oldPasswordController.text;

      final response = await _editService.editName(
          id!, token!, {'name': _nameController.text, 'old_password': old});

      if (response.statusCode == 200) {
        // Atualiza o nome localmente
        userProvider.setName(_nameController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nome atualizado com sucesso')),
        );
      } else {
        throw Exception('Erro ao atualizar o nome');
      }
    } catch (e) {
      print('Erro ao salvar o nome: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o nome: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _isEditingName = false;
      });
    }
  }
  
  Future<void> _editEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<AllProvider>(context, listen: false);
      final token = userProvider.token;
      final id = userProvider.userId;
      final old = _oldPasswordController.text;

      final response = await _editService.editEmail(
          id!, token!, {'email': _emailController.text, 'old_password': old});

      if (response.statusCode == 200) {
        // Atualiza o email localmente
        userProvider.setEmail(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atualizado com sucesso')),
        );
      } else {
        throw Exception('Erro ao atualizar o email');
      }
    } catch (e) {
      print('Erro ao salvar o nome: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o email: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _isEditingEmail = false;
      });
    }
  }

  Future<void> _editPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<AllProvider>(context, listen: false);
      final token = userProvider.token;
      final id = userProvider.userId;
      final old = _oldPasswordController.text;

      final response = await _editService.editPassword(
          id!, token!, {'password': _passwordController.text, 'password_confirmation': _passwordconfirmController.text, 'old_password': old});

      if (response.statusCode == 200) {
        // Atualiza a senha localmente
        userProvider.setPassword(_passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha atualizada com sucesso')),
        );
      } else {
        throw Exception('Erro ao atualizar a senha');
      }
    } catch (e) {
      print('Erro ao salvar o nome: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar a senha: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _isEditingPassword = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context);
    final imageBytes = profileImageProvider.imageBytes;
    final userProvider = Provider.of<AllProvider>(context);
    final user = userProvider.user;
    final imageUrl = user?['profile_image'] ?? '';

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 800,
                      height: 600,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F8DE),
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(-7, 11),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isLoading
                              ? const CircularProgressIndicator()
                              : MouseRegion(
                                  onEnter: (_) =>
                                      setState(() => _isHovering = true),
                                  onExit: (_) =>
                                      setState(() => _isHovering = false),
                                  cursor: _isHovering
                                      ? SystemMouseCursors.click
                                      : SystemMouseCursors.basic,
                                  child: GestureDetector(
                                    onTap: _pickImage,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 80,
                                          backgroundImage: imageBytes != null
                                              ? MemoryImage(imageBytes)
                                              : (imageUrl.isNotEmpty
                                                      ? NetworkImage(imageUrl)
                                                      : const AssetImage(
                                                          'images/default_profile.png'))
                                                  as ImageProvider,
                                          child: imageBytes == null &&
                                                  imageUrl.isEmpty
                                              ? const Icon(Icons.camera_alt,
                                                  size: 50)
                                              : null,
                                        ),
                                        if (_isHovering)
                                          Container(
                                            width: 160,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isEditingName
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite o novo nome',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _oldPasswordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite a Senha Atual',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      userProvider.name ?? 'Nome do Usuário',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'OpenSans-SemiBold',
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isEditingName) {
                                      _editName(); // Salva o nome se já estiver editando
                                    } else {
                                      _isEditingName = true;
                                      _oldPasswordController.clear();
                                    }
                                  });
                                },
                                icon: Icon(
                                  _isEditingName ? Icons.check : Icons.edit,
                                  color: Color(0xFF41337A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isEditingEmail
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite o novo email',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _oldPasswordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite a Senha Atual',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'E-mail: ${userProvider.email}' ?? 'Email do Usuário',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'OpenSans-SemiBold',
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isEditingEmail) {
                                      _editEmail(); // Salva o email se já estiver editando
                                    } else {
                                      _isEditingEmail = true;
                                      _oldPasswordController.clear();
                                    }
                                  });
                                },
                                icon: Icon(
                                  _isEditingEmail ? Icons.check : Icons.edit,
                                  color: Color(0xFF41337A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isEditingPassword
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _passwordController,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite a Nova Senha',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _passwordconfirmController,
                                            decoration: const InputDecoration(
                                              hintText: 'Repita a Nova Senha',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: 200,
                                          child: TextField(
                                            controller: _oldPasswordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Digite a Senha Atual',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Senha: ********',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'OpenSans-SemiBold',
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isEditingPassword) {
                                      _editPassword(); // Salva a senha se já estiver editando
                                    } else {
                                      _isEditingPassword = true;
                                      _passwordController.clear();
                                      _passwordconfirmController.clear();
                                      _oldPasswordController.clear();
                                    }
                                  });
                                },
                                icon: Icon(
                                  _isEditingPassword ? Icons.check : Icons.edit,
                                  color: Color(0xFF41337A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
