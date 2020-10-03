using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.NetworkInformation;

namespace checker
{
	class Program
	{
        static void Main(string[] args)
        { 
	
            //check for connectivity
            if (!NetworkInterface.GetIsNetworkAvailable())
            {
                return;
            }
            else
            {
                Console.WriteLine("Network found.");
                NetworkInterface[] interfaces = NetworkInterface.GetAllNetworkInterfaces();

                foreach (NetworkInterface ni in interfaces)
                {
                    //testing different properties
                    Console.WriteLine("Description: {0}", ni.Description.ToString());
                    Console.WriteLine("ID: {0}" ,ni.Id.ToString());
                    Console.WriteLine("IPv4 Properties: {0}", ni.GetIPProperties().GetIPv4Properties().ToString());
                    Console.WriteLine("DNS: {0}", ni.GetIPProperties().DnsAddresses.ToArray());
                    Console.WriteLine("Gateway: {0}", ni.GetIPProperties().GatewayAddresses.ToString());
                    Console.WriteLine("IPv6 Properties: {0}", ni.GetIPProperties().GetIPv6Properties().ToString());
                    Console.WriteLine("Bytes Received: {0}" ,ni.GetIPStatistics().BytesReceived);
                    Console.WriteLine("GigaBytes Received: {0}", ni.GetIPStatistics().BytesReceived/1024);
                    Console.WriteLine("Bytes Sent: {0}", ni.GetIPStatistics().BytesSent);
                    Console.WriteLine("GigaBytes Sent: {0}", ni.GetIPStatistics().BytesSent/1024);
                    Console.WriteLine("\n");
                }
                
            }
            Console.ReadLine();
            
		}
	}
}
