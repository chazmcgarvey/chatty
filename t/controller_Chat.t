use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Chatty';
use Chatty::Controller::Chat;

ok( request('/chat')->is_success, 'Request should succeed' );
done_testing();
