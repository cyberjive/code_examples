using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

//easy - i before e except after c
namespace dailyprogrammer_363
{
    class Program
    {
        static void Main(string[] args)
        {
            //TODO check expression match for edge cases, total exception value (bonus) is still wrong...
            string [] input = System.IO.File.ReadAllLines(@"C:\Users\james.putterman\My Documents\enable1.txt");
            //string[] input = { "a", "zombie", "transceiver", "veil", "icier" };
            Regex reg = new Regex(@"cie");
            Regex reg2 = new Regex(@"[^c]ei");
            int exceptionVal = 0;

            foreach (string word in input)
            {
                Match match = reg.Match(word);
                Match match2 = reg2.Match(word);
                if (match.Success == true)
                {
                    //Console.WriteLine("{0} : False", word);
                    exceptionVal += 1;
                }
                else if (match2.Success == true)
                {
                    //Console.WriteLine("{0} : True", word);
                    exceptionVal += 1;
                }
                else
                {
                    continue;
                }
            }
            Console.WriteLine("Exceptions : {0}", exceptionVal);
            Console.ReadLine();
        }
    }
}
