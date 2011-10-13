use strict;
use warnings;

use Chatty;

my $app = Chatty->apply_default_middlewares(Chatty->psgi_app);
$app;

