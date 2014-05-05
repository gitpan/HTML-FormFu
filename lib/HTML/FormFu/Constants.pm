package HTML::FormFu::Constants;
$HTML::FormFu::Constants::VERSION = '2.01';
use strict;
use warnings;
use Readonly;
use Exporter qw( import );

Readonly our $EMPTY_STR => q{};
Readonly our $SPACE     => q{ };

our @EXPORT_OK = qw(
    $EMPTY_STR
    $SPACE
);

1;
