using System;
using System.Collections.Generic;
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
        public static List<IDataConnection> Connections { get; private set; } = new List<IDataConnection>();

        public static void InitializaConnections(bool database, bool textFiles)
        {
            if (database)
            {
                //Todo - Set up the SQL Connector properly
                SqlConnector sql = new SqlConnector();
                Connections.Add(sql);
            }
            if (textFiles)
            {
                //Todo - Create the text connection
                TextConnector text = new TextConnector();
                Connections.Add(text);
            }
        }
    }
}
