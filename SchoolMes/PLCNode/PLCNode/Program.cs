using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OPCAutomation;

namespace PLCNode
{
    class Program
    {
        static void Main(string[] args)
        {
            OPCServer server = new OPCServer();
            server.Connect("KEPware.KEPServerEx.V5", "127.0.0.1");
        }
    }
}
