// (C) 2009, Parrot Foundation
// $Id: fib.cs 43073 2009-12-15 17:14:04Z NotFound $

// Fibonacci Benchmark

using System;
using System.Diagnostics;

namespace str
{
    class MainClass
    {
        public static void Main (string[] args)
        {
            var sw = new Stopwatch(); sw.Start();
            var n = args.Length > 0 ? Int32.Parse(args[0]) : 28;
            var result = _fib(n);
            sw.Stop();
            Console.WriteLine ("fib(" + n + ") = " + result);
            Console.WriteLine ("Elapsed: " + sw.Elapsed);
        }
        static int _fib (int n) {
            return n < 2 ? n : _fib(n - 1) + _fib(n - 2);
        }
    }
}
