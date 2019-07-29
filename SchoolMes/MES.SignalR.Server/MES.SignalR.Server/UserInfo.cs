using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MES.SignalR.Server
{
    public class UserInfo
    {
        public string ConnectionId { get; set; }
        public string UserName { get; set; }
        public DateTime LastLoginTime { get; set; }

    }
}
