use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious' => '3.59'
    },
    test      => {TESTS => 't/*.t'}
);
