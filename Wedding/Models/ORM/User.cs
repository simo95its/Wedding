using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Wedding.Models.ORM
{
    public class User
    {
        public int IdUser { get; set; }
        public string Email { get; set; }
        public int IdRole { get; set; }
        public string PasswordHash { get; set; }
    }
}