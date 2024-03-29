package Chatty;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    StackTrace
    Static::Simple
    Authentication
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    Unicode::Encoding
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in chatty.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
	name => 'Chatty',
	using_frontend_proxy => 1,
	# Disable deprecated behavior needed by old applications
	disable_component_resolution_regex_fallback => 1,
	'Plugin::Authentication' => {
		default => {
			class           => 'SimpleDB',
			user_model      => 'DB::Account',
			password_type   => 'clear',
		},
	},
	'Plugin::Session' => {
		flash_to_stash => 1,
	},
	default_view => 'HTML',
	'View::JSON' => {
		expose_stash => 'json',
	},
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Chatty - Catalyst based application

=head1 SYNOPSIS

    script/chatty_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Chatty::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
