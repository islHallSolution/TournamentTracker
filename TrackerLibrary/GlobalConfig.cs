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
        public const string PrizesFile = "PrizeModels.csv";
        public const string PeopleFile = "PersonModel.csv";
        public const string TeamFile = "TeamModels.csv";
        public const string TournamentFile = "TournamentFile.csv";
        public const string MatchupFile = "MatchupModels.csv";
        public const string MatchupEntryFile = "MatchupEntryModels.csv";

        /// <summary>
        /// Ninguem de fora pode modificar seu valor
        /// </summary>
        public static IDataConnection Connection { get; private set; }

        public static void InitializaConnections(DatabaseType db)
        {
            if (db == DatabaseType.Sql)
            { 
                SqlConnector sql = new SqlConnector();
                Connection = sql;
            }
            else if (db == DatabaseType.TextFile)
            { 
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
