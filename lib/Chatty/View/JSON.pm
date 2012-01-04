package Chatty::View::JSON;

use JSON::XS ();

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

extends 'Catalyst::View::JSON';

sub encode_json {
	my ($self, $c, $data) = @_;
	JSON::XS->new->ascii->pretty->allow_nonref->encode($data);
}

=head1 NAME

Chatty::View::JSON - Catalyst View

=head1 DESCRIPTION

Catalyst View.

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
