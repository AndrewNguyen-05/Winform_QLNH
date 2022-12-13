﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Winform_QLNH.DTO;

namespace Winform_QLNH.DAO
{
    internal class BillDAO
    {
        private static BillDAO instance;

        internal static BillDAO Instance 
        {
            get 
            { 
                if(instance == null) BillDAO.instance = new BillDAO();
                return instance;
            } 
            set => instance = value; 
        }

        private BillDAO() { }

        //Thành công: bill.ID
        //Thất bại: -1
        public int GetUncheckBillIDbyTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM Bill WHERE idTable = " + id + " AND status = 0");
            if(data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;
        }
    }
}