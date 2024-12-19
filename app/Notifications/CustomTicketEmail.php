<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use App\Models\Tickets;

class CustomTicketEmail extends Notification
{
    use Queueable;

    protected $ticket;

    public function __construct(Tickets $ticket)
    {
        $this->ticket = $ticket;
    }

    /**
     * Determine the channels the notification should be sent through.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        // Define os canais através dos quais a notificação será enviada
        return ['mail']; // Envia apenas por email
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('Novo Ticket Criado')  // Assunto do e-mail
            ->greeting('Olá, ' . $notifiable->name)  // Saudação personalizada
            ->line('Um novo ticket foi criado com as seguintes informações:')
            ->line('Assunto: ' . $this->ticket->assunto)  // Exibe o assunto do ticket
            ->line('Descrição: ' . $this->ticket->descricao)  // Exibe a descrição do ticket
            ->action('Ver Ticket', url('/tickets/'.$this->ticket->id))  // Link para o ticket
            ->line('Obrigado por usar nosso sistema!');  // Mensagem final
    }

    // Caso queira enviar dados para outro canal (exemplo, banco de dados), adicione outro método como toDatabase().
}
