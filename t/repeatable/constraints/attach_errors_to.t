use strict;
use warnings;

use Test::More tests => 5;

use HTML::FormFu;
use lib 't/lib';
use HTMLFormFu::TestLib;

my $form = HTML::FormFu->new;

$form->load_config_file('t/repeatable/constraints/attach_errors_to.yml');

$form->get_element( { type => 'Repeatable' } )->repeat(2);

# Missing - Invalid
{
    $form->process( {
            'rep_1.foo' => 'AAA',
            'rep_1.bar' => '',
            count       => 1,
        } );

    ok( !$form->submitted_and_valid );

    ok( $form->has_errors('rep_1.foo') );
    ok( $form->has_errors('rep_1.bar') );

    like( $form->get_field( { nested_name => 'rep_1.foo' } ), qr/error/ );
    like( $form->get_field( { nested_name => 'rep_1.bar' } ), qr/error/ );
}

