package HTML::FormFu::Preload;
$HTML::FormFu::Preload::VERSION = '2.00';
use strict;
use HTML::FormFu;

use Module::Pluggable (
    search_path => [ qw(
            HTML::FormFu::Element
            HTML::FormFu::Constraint
            HTML::FormFu::Deflator
            HTML::FormFu::Filter
            HTML::FormFu::Inflator
            HTML::FormFu::Transformer
            HTML::FormFu::Validator
            HTML::FormFu::Plugin
            HTML::FormFu::OutputProcessor
            )
    ],
    require => 1
);

__PACKAGE__->plugins;

1;
