//r/dailyprogrammer challenge #364
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication3
{
    class Program
    {
        static void Main(string[] args)
        {
            //TODO make input actual input in form 'xdxx'
            string input = "4d12";
            char diceToRoll = input[0];
            int diceVal = (int)Char.GetNumericValue(diceToRoll);
            string numSides = input.Substring(2);
            int numSidesVal = Int32.Parse(numSides);

            Random rnd = new Random();
            int returnVal = 0;
            int counter = diceVal;

            while (counter != 0)
            {
                returnVal += rnd.Next(1, numSidesVal);
                counter--;
            }

            Console.WriteLine("Dice " + diceToRoll.ToString());
            Console.WriteLine("Sides " + numSidesVal.ToString());
            Console.WriteLine("Roll " + returnVal.ToString());
            Console.ReadLine();


        }
    }
