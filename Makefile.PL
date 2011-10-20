#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Chatty';
all_from 'lib/Chatty.pm';

requires 'Catalyst::Runtime' => '5.90002';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'Catalyst::Action::RenderView';
requires 'JSON';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

# Add targets to run the developer server.
sub MY::postamble {
	return <<END;
run: all
	./script/chatty_server.pl -r
debug: all
	./script/chatty_server.pl -r -d
END
}

install_script glob('script/*.pl');
auto_install;
WriteAll;
