use v6;
use Test;
use JavaScript::SpiderMonkey;


is js-eval(q:to/JS/).type, 'object', 'evaling an object literal';
    car = {
        seats  : "leather",
        plates : true,
        doors  : [1, 2.3],
    };
    JS

my $car = js-eval('car');
is $car.type, 'object', 'referencing evaled object';


for $car<seats>
{
    is .type, 'string',  'referencing string property';
    is .Str,  'leather', 'string property has right content';
}


for $car<plates>
{
    is .type, 'boolean', 'referencing boolean property';
    is .Bool,  True,     'boolean property has right content';
}


for $car<doors>
{
    is .type, 'object', 'referencing array property';

    for .[0]
    {
        is .type, 'number', 'referencing number in array';
        cmp-ok .Num, '==', 1, 'number has right content';
    }

    for .[1]
    {
        is .type, 'number', 'another number in array';
        cmp-ok .Num, '==', 2.3, 'also has right content';
    }

    is .[2].type, 'undefined', 'referencing nonexistent array element';
}


done-testing
