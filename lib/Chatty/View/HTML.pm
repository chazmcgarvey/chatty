package Chatty::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION => '.tt',
	INCLUDE_PATH => [
		Chatty->path_to('root', 'tt'),
	],
	WRAPPER => 'wrapper.tt',
	render_die => 1,
	COMPILE_DIR => '/tmp/tt_cache',
);


=head1 NAME

Chatty::View::HTML - TT View for Chatty

=head1 DESCRIPTION

TT View for Chatty.

=head1 SEE ALSO

L<Chatty>

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
