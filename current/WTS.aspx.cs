﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class experimental_WTS : System.Web.UI.Page
{
    
    databaseLogic dbLogic = new databaseLogic();
    DataSet ds = new DataSet();
    string query = "";
    string id;
    string[] info;
    protected void Page_Load(object sender, EventArgs e)
    {
        
       //Submit.Attributes.Add("onClick", "alert('You may only run for this position once!');");


        string fullPath = Request.PathInfo;

        if (!Page.IsPostBack)
        {
            //new method to retrieve
            if (fullPath != "")
            {
                string[] categoryList;
                categoryList = fullPath.Substring(1).TrimEnd('/').Split('/');
                string queryVal = categoryList[0]; //variable name of querystring
                string positionTitle = dbLogic.selectPositionFromID(queryVal);
                LabelHeader.Text = positionTitle + " Willingness To Serve Form:";
                LabelExplain.Text = "If you are willing to hold a place in office as " + positionTitle + ", please fill out the following form:";
                HiddenFieldPosition.Value = positionTitle;
            }
        }
        
        id = dbLogic.returnUnionIDFromUsername(Page.User.Identity.Name.ToString());        
        dbLogic.selectUserInfoFromUnionId( id );
        ds = dbLogic.getResults();
        info = new string[3] {id, id, HiddenFieldPosition.Value};

        Name.Text = ds.Tables[0].Rows[0].ItemArray[2].ToString() + " " + ds.Tables[0].Rows[0].ItemArray[1].ToString();
        Dept.Text = ds.Tables[0].Rows[0].ItemArray[5].ToString();
    }

    protected bool checkAccept()
    {
        if (Accept.Checked == true)
            return true;
        else
            return false;
    }

    protected void submit(object sender, EventArgs e)
    {
        
        if (checkAccept())
        {              
            if (!dbLogic.isUserWTS(id, HiddenFieldPosition.Value))
            {
                dbLogic.insertIntoWTS(id, Statement.Text, HiddenFieldPosition.Value);
                if ( !dbLogic.isUserNominated(id, HiddenFieldPosition.Value) )
                {
                    dbLogic.insertNominationAccept(info);
                }             
                dbLogic.userAcceptedNom(id, HiddenFieldPosition.Value);
                AcceptError.Visible = false;
                UpdatePanel1.Visible = false;
                LabelExplain.Visible = false;
                Confirm.Visible = true;
            }
            else
            {
                LabelExplain.Text = "You have already applied for this position.";
                UpdatePanel1.Visible = false;
            }
        } 
        else
        {
            AcceptError.Visible = true;   
        }
    }

    protected bool checkWTS()
    {
        return dbLogic.isUserWTS(id, HiddenFieldPosition.Value);
    }
}