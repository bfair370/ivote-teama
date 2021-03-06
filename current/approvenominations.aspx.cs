﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class wwwroot_experimental_approvenominations : System.Web.UI.Page
{
    databaseLogic dbLogic = new databaseLogic();
    VerifyEmail email = new VerifyEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dbLogic.selectInfoForApprovalTable();
            DataSet emailSet = dbLogic.getResults();
            ListViewApproval.DataSource = emailSet;
            ListViewApproval.DataBind();
            loadApprovalInfo();
        }
    }

    protected void loadApprovalInfo()
    {
        foreach (ListViewDataItem eachItem in ListViewApproval.Items)
        {
            HiddenField eligible = (HiddenField)eachItem.FindControl("HiddenFieldEligible");
            RadioButton approve = (RadioButton)eachItem.FindControl("RadioButton1");
            RadioButton deny = (RadioButton)eachItem.FindControl("RadioButton2");
            if (eligible.Value == "1")
            {
                approve.Checked = true;
            }
            else if(eligible.Value == "0")
                deny.Checked = true;
        }
    }

    //saves user changes
    protected void Click_ButtonSave(object sender, EventArgs e)
    {
        int count = 0;
        foreach (ListViewDataItem eachItem in ListViewApproval.Items)
        {
            bool changeMade = false;
            HiddenField id = (HiddenField)eachItem.FindControl("HiddenFieldID");
            HiddenField eligible = (HiddenField)eachItem.FindControl("HiddenFieldEligible");
            Label fullname = (Label)eachItem.FindControl("LabelFullname");
            Label position = (Label)eachItem.FindControl("LabelPosition");
            Label statement = (Label)eachItem.FindControl("LabelStatement");
            RadioButton approve = (RadioButton)eachItem.FindControl("RadioButton1");
            RadioButton deny = (RadioButton)eachItem.FindControl("RadioButton2");

            if (approve.Checked == true)
            {
                dbLogic.updateEligible(id.Value, "1");
                //email to user saying they were accepted
                email.approveUserEligibility(id.Value);

                if (eligible.Value != "1")
                {
                    count += 1;
                    eligible.Value = "1";
                }
            }
            else if (deny.Checked == true)
            {
                dbLogic.updateEligible(id.Value, "0");
                //email to user saying they were rejected
                email.denyUserEligibility(id.Value);

                if (eligible.Value != "0")
                {
                    count += 1;
                    eligible.Value = "0";
                }
            }
            
        }
        if (count > 0)
            LabelFeedback.Text = "Save successful. " + count.ToString() + " nomination(s) changed.";
        else
            LabelFeedback.Text = "No changes made.";
    }

    //hides popup
    protected void ButtonDone_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }

    //shows full statement
    protected void showFullStatement(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "statement"))
        {
            LabelFullStatment.Text = "\"" + e.CommandArgument.ToString() + "\"";
            ModalPopupExtender1.Show();
            PanelStatement.Visible = true;
        }
    }

}