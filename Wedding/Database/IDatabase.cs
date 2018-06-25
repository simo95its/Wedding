using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Wedding.Models.ORM;

namespace Wedding.Database
{
    public interface IDatabase
    {
        User ReadUser(string email, string password);
    }
}
