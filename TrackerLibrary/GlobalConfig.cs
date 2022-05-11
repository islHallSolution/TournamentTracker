using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.DataAccess;

namespace TrackerLibrary
{
    public static class GlobalConfig
    {
        /// <summary>
        /// Ninguem de fora pode modificar seu valor
        /// </summary>
        public static IDataConnection Connection { get; private set; }

        public static void InitializaConnections(DatabaseType db)
        {
            if (db == DatabaseType.Sql)
            {
                //Todo - Set up the SQL Connector properly
                SqlConnector sql = new SqlConnector();
                Connection = sql;
            }
            else if (db == DatabaseType.TextFile)
            {
                //Todo - Create the text connection
                TextConnector text = new TextConnector();
                Connection = text;
            }
        }
        /// <summary>
        /// Return connection string. This case is app.config.
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public static string CnnString(string name)
        {
            return ConfigurationManager.ConnectionStrings[name].ConnectionString;
        }
    }
}
