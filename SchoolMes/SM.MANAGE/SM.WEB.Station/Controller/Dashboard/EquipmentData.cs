using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SM.WEB.Station.Controller.Dashboard
{
    public class EquipmentData
    {
        public virtual string id { get; set; }
        public virtual string ParentId { get; set; }
        public virtual string EquipmentCode { get; set; }
        public virtual string text { get; set; }
        public virtual string EquipmentDesc { get; set; }
        public virtual string Team { get; set; }
        public virtual string EquipmentImg { get; set; }
        public virtual string PLCIP { get; set; }
        public virtual string PLCDB { get; set; }
        public virtual string IsPayPoint { get; set; }
        public virtual string DesignCycletime { get; set; }
        public virtual string DesignJPH { get; set; }
        public virtual string EquipmentSupplier { get; set; }
        public virtual string Counter { get; set; }
        public virtual List<EquipmentData> children { get; set; }
    }
}