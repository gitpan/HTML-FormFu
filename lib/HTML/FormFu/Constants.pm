package HTML::FormFu::Constants;
{
  $HTML::FormFu::Constants::VERSION = '1.00';
}

use strict;
use Readonly;
use Exporter qw( import );

Readonly our $EMPTY_STR => q{};
Readonly our $SPACE     => q{ };

our @EXPORT_OK = qw(
    $EMPTY_STR
    $SPACE
);

1;
