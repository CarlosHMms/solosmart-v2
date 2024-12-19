<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class CustomResetPasswordNotification extends Notification
{
    protected $code;

    public function __construct($code)
    {
        $this->code = $code;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('Código de Redefinição de Senha')
            ->greeting('Olá')
            ->line('Seu código de redefinição de senha é:')
            ->line($this->code)
            ->line('Este código é válido apenas para esta solicitação.')
            ->line('Se você não solicitou a redefinição de senha, ignore este e-mail.');
    }
}
