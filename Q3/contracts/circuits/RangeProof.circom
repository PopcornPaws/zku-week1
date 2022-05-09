pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";

template RangeProof(n) {
    assert(n <= 252);
    signal input in; // this is the number to be proved inside the range
    signal input range[2]; // the two elements should be the range, i.e. [lower bound, upper bound]
    signal output out;

    component low = LessEqThan(n);
    component high = GreaterEqThan(n);

    // less than the upper bound (range[1])
    low.in[0] <== in;
    low.in[1] <== range[1];

    // greater than the lower bound (range[0])
    high.in[0] <== in;
    high.in[1] <== range[0];

    // both checks should pass to be in range
    out <== low.out * high.out;
}

template RangeProofMain(lower, upper) {
    signal input in;
    signal output out;
    component rp = RangeProof(32);
    rp.in <== in;
    rp.range[0] <== lower;
    rp.range[1] <== upper;

    rp.out ==> out;
}

//component main = RangeProofMain(10, 20);