package Chatty::Model::Meteor;
use Moose;
use namespace::autoclean;

use IO::Socket;

extends 'Catalyst::Model';

# TODO: does not reconnect to cometd if connection is broken
has 'cnx' => (
	is => 'ro',
	lazy => 1,
	required => 1,
	default => sub {
		IO::Socket::INET->new(
			PeerAddr => 'localhost',
			PeerPort => 4671,
			Proto => 'tcp'
		);
	},
);

=head1 NAME

Chatty::Model::Meteor - Catalyst Model

=head1 DESCRIPTION

Handles interaction with the meteor comet server.

=head1 METHODS

=head2 addMessage

Post a message to the server.

=cut

sub addMessage {
	my ($self, $channel, $message) = @_;
	my $cnx = $self->cnx;
	print $cnx "ADDMESSAGE $channel $message\n";
}

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
1;
