/*****************************************************************************
*
*                      Higgs JavaScript Virtual Machine
*
*  This file is part of the Higgs project. The project is distributed at:
*  https://github.com/maximecb/Higgs
*
*  Copyright (c) 2011, Maxime Chevalier-Boisvert. All rights reserved.
*
*  This software is licensed under the following license (Modified BSD
*  License):
*
*  Redistribution and use in source and binary forms, with or without
*  modification, are permitted provided that the following conditions are
*  met:
*   1. Redistributions of source code must retain the above copyright
*      notice, this list of conditions and the following disclaimer.
*   2. Redistributions in binary form must reproduce the above copyright
*      notice, this list of conditions and the following disclaimer in the
*      documentation and/or other materials provided with the distribution.
*   3. The name of the author may not be used to endorse or promote
*      products derived from this software without specific prior written
*      permission.
*
*  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
*  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
*  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
*  NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
*  NOT LIMITED TO PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
*  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
*  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*****************************************************************************/

module interp.tests;

import std.stdio;
import std.string;
import parser.parser;
import ir.ast;
import interp.interp;

Interp evalString(string input)
{
    auto ast = parseString(input);
    auto ir = astToIR(ast);

    Interp interp = new Interp();

    //writeln(ir.toString());
    //writeln("executing");

    interp.exec(ir);

    return interp;
}

void assertInt(string input, long intVal)
{
    auto interp = evalString(input);

    //writeln("getting ret val");

    auto ret = interp.getRet();

    assert (
        ret.type == Type.INT,
        "non-integer type"
    );

    assert (
        ret.word.intVal == intVal,
        format(
            "incorrect integer value: %s, expected: %s",
            ret.word.intVal, 
            intVal
        )
    );
}

unittest
{
    Word w0 = Word.intg(0);
    Word w1 = Word.intg(1);

    assert (w0.intVal != w1.intVal);
}

/// Global expression tests
unittest
{
    assertInt("return 7", 7);

    assertInt("return 1 + 2", 3);

    assertInt("return 5 - 1", 4);

    assertInt("return -3", -3);

    assertInt("return 2 + 3 * 4", 14);
}

// TODO: basic interpreter tests
// return global exprs
// return global call
// parameter passing

