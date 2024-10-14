<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\URL;
use Carbon\Carbon;

class CustomResetPasswordNotification extends Notification
{
    public $token;

    public function __construct($token)
    {
        $this->token = $token;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        $flutterUrl = 'http://localhost:50000/reset';
        $url = $flutterUrl . '?token=' . $this->token . '&email=' . urlencode($notifiable->email);

        return (new MailMessage)
            ->subject('Recuperação de Senha - SoloSmart')
            ->greeting('Olá, ' . $notifiable->name . '!')
            ->line('Você está recebendo este e-mail porque solicitou a redefinição de senha para sua conta.')
            ->action('Resetar Senha', $url)
            ->line('Se você não solicitou uma redefinição de senha, nenhuma ação é necessária.')
            ->line('Obrigado por usar nossa aplicação!');
    }
}
