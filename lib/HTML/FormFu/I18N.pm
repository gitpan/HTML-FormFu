package HTML::FormFu::I18N;
$HTML::FormFu::I18N::VERSION = '2.01';
use Moose;

extends 'Locale::Maketext';

*loc = \&localize;

sub localize {
    my $self = shift;

    return $self->maketext(@_);
}

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
