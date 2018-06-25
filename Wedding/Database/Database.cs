using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Wedding.Configuration;
using Wedding.Models.ORM;

namespace Wedding.Database
{
    public class Database : IDatabase
    {
        private readonly IConfiguration _config;

        public Database(IConfiguration config)
        {
            _config = config;
        }

        public User GetUser(string email, string password)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@email", email));
            parameters.Add(new SqlParameter("@password", password));
            using (var reader = Read("GetUser", parameters))
            {
                reader.
                var users = new User();
                while (reader.Read())
                {
                    user.IdUser = (int)reader["id_user"];
                    user.Email = (string)reader["email"];
                    user.IdRole = (int)reader["id_role"];
                    user.PasswordHash = (string)reader["password_hash"];
                }
            }
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(_config.ConnectionToWedding);
        }

        private SqlDataReader Read(string cmdName, IEnumerable<SqlParameter> parameters)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                using (var cmd = new SqlCommand(cmdName, conn))
                {
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.Add(param);
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    return cmd.ExecuteReader();
                }
            }
        }
    }
}