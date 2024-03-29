package HTML::FormFu::Element::Src;
$HTML::FormFu::Element::Src::VERSION = '2.01';
use Moose;
extends 'HTML::FormFu::Element::Block';

after BUILD => sub {
    my $self = shift;

    $self->tag(undef);

    return;
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Element::Src - custom HTML element

=head1 DESCRIPTION

Allows you to add markup directly into the form, without surrounding 
C<< <div> </div> >> tags.

=head1 SEE ALSO

Is a sub-class of, and inherits methods from 
L<HTML::FormFu::Element::Block>, 
L<HTML::FormFu::Element>

L<HTML::FormFu>

=head1 AUTHOR

Carl Franks, C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
