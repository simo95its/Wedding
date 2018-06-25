using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Wedding.Configuration
{
    public class Configuration : IConfiguration
    {
        public string ConnectionToWedding => GetConnectionString("wedding");

        private string GetConnectionString(string dbName)
        {
            return ConfigurationManager.ConnectionStrings[dbName].ConnectionString;
        }
    }
}