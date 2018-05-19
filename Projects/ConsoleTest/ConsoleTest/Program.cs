using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleTest
{
    class Program
    {
        static void Main(string[] args)
        {
            var obj = new {Name = "Tyler", Age = 28};
            string jsonStr = JsonConvert.SerializeObject(obj);
            Console.WriteLine(jsonStr);
            Console.ReadKey();
        }
    }
}
