﻿<%@ Page Title="iVote" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"  TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Content-->
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:Label ID="lblTest" runat="server" />
    <!--Notifications-->
    <asp:Panel ID="PanelNominationPending" Visible="false" Enabled="false" runat="server">
            <div id="notifications">
                <asp:Panel id="nom_pending" class="notification" Visible="false" Enabled="false" runat="server">
                    <b>You have a nomination pending! </b>
                    <asp:LinkButton ID="LinkButton5"  commandname="id" CommandArgument="Nominations.aspx"  OnCommand="transfer"
                        text="View Nominations." runat="server" />
                </asp:Panel>
                <asp:Panel ID="elig_pending" class="notification" Visible="false" Enabled="false" runat="server">
                    <b>There are eligibility forms that must be approved. </b>
                    <asp:LinkButton ID="LinkButton6"  commandname="id" CommandArgument="approvenominations.aspx"  OnCommand="transfer"
                        text="Approve Eligibility" runat="server" />
                </asp:Panel>
            </div>
     </asp:Panel>

    <!--End Notifications-->

    <!--Nominations-->
    <asp:Panel ID="lblNominate" Enabled="false" Visible="false" runat="server">
    
        <div id="bodyCopy">
            <h1>Nomination Period</h1>
            The current election is in a nomination period.  During this period, you may nominate yourself or other faculty members.
        </div>

        <!--Admin only-->
        <asp:Panel id="functions_nominate" style="margin-top:10px;" visible="false" runat="server">
            <div class="column">
                <b>User Management</b><br />
                <asp:LinkButton ID="LinkButton2"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                            text="Create User" runat="server" /><br />
                <asp:LinkButton ID="LinkButton4"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                            text="Edit User" runat="server" /><br />
            
            </div>
            <div class="column">
                <b>Election Management</b><br />
                <a href="approvenominations.aspx">Approve Eligibility</a><br />
                <a href="terminate.aspx">Cancel election</a>
                <br />
            </div>
        </asp:Panel>
        

        <div class="clear"></div>
    
        <!--For this phase, we'll show the nomination functionality.-->
        <div id="special" style="text-align: center">
            <asp:Label ID="LabelResponse" runat="server" Text="" />
            <br />
            <br />
        

            <span style="color: Blue">Click <b>Select</b>, next to each position below, to nominate yourself or view information for that position.</span><br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <!-- List of positions -->
                    <asp:GridView ID="GridViewPositions" AutoGenerateColumns="false" OnRowCommand="GridViewPositions_RowCommand" CssClass="simpleGrid" runat="server">
                         <Columns>        
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:Button ID="ButtonSelect" runat="server" commandname="positions" commandargument='<%#Eval("position") %>' Text="Select" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Postion Name" DataField="position" NullDisplayText="Error"/> 

                        </Columns>
                    </asp:GridView>

                    <!--Display form/data for selected position -->
                    <asp:Panel ID="PanelSelected" CssClass="simpleBorder" Visible="false" runat="server">
                        <br />
                        <asp:Label ID="LabelSelected" runat="server" Text="" />
                        <p class="submitButton"> 
                        <asp:Button ID="ButtonNominate" Width="255" runat="server" OnClick="nominate" Text="" /><br />
                        <asp:Button ID="ButtonWTS" Width="255" runat="server" Text="" OnClick="next" /> 
                        </p>
                        <asp:HiddenField ID="HiddenFieldID" runat="server" />
                    </asp:Panel>
            


                </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </asp:Panel>

    <!--End Nominations-->
    
    <!--Acceptance 1 phase-->
    <asp:Panel ID="lblAccept1" Enabled="false" Visible="false" runat="server">
        <div id="bodyCopy">
                <h1>Nomination Acceptance Period</h1>
                The current election is in a nomination acceptance period.  This period acts as a buffer to give extra time to accept nominations.
            </div>

            <!--Admin only-->
            <asp:Panel id="functions_accept1" style="margin-top:10px;" visible="false" runat="server">
                <div class="column">
                    <b>User Management</b><br />
                    <asp:LinkButton ID="LinkButton3"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                                text="Create User" runat="server" /><br />
                    <asp:LinkButton ID="LinkButton8"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                                text="Edit User" runat="server" /><br />
            
                </div>
                <div class="column">
                    <b>Election Management</b><br />
                    <a href="approvenominations.aspx">Approve Eligibility</a><br />
                    <a href="terminate.aspx">Cancel election</a>
                    <br />
                </div>
            </asp:Panel>
        

            <div class="clear"></div>
    
            </div>
    </asp:Panel>

    <!--end acceptance 1-->


    <!--Slate Approval -->
    <asp:Panel ID="lblSlate" Enabled="false" Visible="false" runat="server">
        <div id="bodyCopy">
            <h1>Slate Approval</h1>
            NEC Members:  Please review and approve the slate below.  If there is a strong reason not to approve the slate, 
            contact the administrator with an explaination and have them cancel the election.
        </div>

        <!--Admin only-->
        <asp:Panel id="functions_slate" style="margin-top:10px;" visible="false" runat="server">
            <b>This is a special phase where the NEC must approve the slate.</b><br /><br />
            <div class="clear"></div>
            <div class="column">
                <b>User Management</b><br />
                <asp:LinkButton ID="LinkButton17"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                            text="Create User" runat="server" /><br />
                <asp:LinkButton ID="LinkButton18"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                            text="Edit User" runat="server" /><br />
            
            </div>
            <div class="column">
                <b>Election Management</b><br />
                <a href="approvenominations.aspx">Approve Eligibility</a><br />
                <a href="terminate.aspx">Cancel election</a><br />
                <a href="removeFromBallot.aspx">Remove Candidate(s) From Slate</a>
                <br />
            </div>
        </asp:Panel>

        <div class="clear"></div>

        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <div style="color: Blue; padding-bottom: 6px;"><asp:Label ID="LabelFeedback2" runat="server" Text="To view the nominated for a position, please select a position from the list below"></asp:Label></div>
            
                <asp:Panel ID="PanelSlateWrapper2" runat="server">
                    <div id="slateWrapper2" style="width: 710px; height: 385px; background-color: #FF9999;">
                        <!-- Holds the positions in the election -->
                        <asp:Panel ID="PanelPositions2" CssClass="slateListPositions" runat="server">
                            <asp:ListView ID="ListViewPositions2"  OnItemCommand="ListViewPositions2_ItemCommand" runat="server">
                                <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                </LayoutTemplate>
                                <ItemTemplate>
                                        <asp:LinkButton ID="LinkButtonPostions" CssClass="bold" runat="server" CommandName="position" CommandArgument='<%#Eval("position")%>' Text='<%#Eval("position")%>' /><br />
                                    <span style="font-size: 12px; font-weight: bold; color: #808080">
                                        <asp:Label ID="LabelVotedExtra2" runat="server" Text=""></asp:Label>
                                        <asp:Label ID="LabelVoted2" runat="server" Text=""></asp:Label>
                                        <asp:HiddenField ID="HiddenFieldVotedId2" runat="server" />
                                        <asp:HiddenField ID="HiddenFieldVoteNumber" Value='<%#Eval("votes_allowed")%>' runat="server" />
                                        <asp:HiddenField ID="HiddenFieldAllCandidates" Value="" runat="server" />
                                    </span>
                                    <hr />
                                </ItemTemplate>
                            </asp:ListView>
                        </asp:Panel>
                        <!-- Holds the people nominated for each position -->
                        <asp:Panel ID="PanelPeople2" CssClass="slateListPeople" Visible="false" runat="server">
                            <asp:ListView ID="ListViewPeople2" OnItemCommand="ListViewPeople2_ItemCommand" runat="server">
                                 <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButtonPostions" runat="server" CssClass="bold" CommandName="id" CommandArgument='<%#Eval("idunion_members")%>' Text='<%#Eval("fullname")%>' /><br /><hr />
                                </ItemTemplate>
                            </asp:ListView>
                        </asp:Panel>
                        <!-- Holds submit button and the info that belows to that persion -->
                        <asp:Panel ID="PanelSelect2" CssClass="slateDetailPeople" Visible="false" runat="server">
                            <span style="text-decoration: underline; font-weight: bolder">
                                Their Personal Statement:
                            </span>
                            <br />
                            <div style="overflow: auto; width: 280px; height: 290px;">
                                <asp:Label ID="LabelStatement2" runat="server" Text="" />
                            </div>
                            <asp:HiddenField ID="HiddenFieldName2" runat="server" />
                            <asp:HiddenField ID="HiddenFieldId2" runat="server" />
                        </asp:Panel>
                    </div>
                    <br />
                    <br />
                    <asp:HiddenField ID="HiddenFieldCurrentPosition2" runat="server" />
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
           <asp:Button ID="btnApprove" Enabled="false" Visible="false" Text="Approve Slate" OnClick="btnApprove_OnClick" runat="server" />
    </asp:Panel>

    <!--End Slate Approval-->

    <!--Petition-->
    <asp:Panel ID="lblPetition" Enabled="false" Visible="false" runat="server">
        <div id="bodyCopy">
            <h1>Petition Period</h1>
            The current election is in the petition phase.  You can petition yourself or other faculty 
            members for a position.
        </div>
        <asp:Panel id="functions_petition" style="margin-top:10px;" visible="false" runat="server">
            <div class="column">
                <b>User Management</b><br />
                <asp:LinkButton ID="LinkButton1"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                            text="Create User" runat="server" /><br />
                <asp:LinkButton ID="LinkButton7"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                            text="Edit User" runat="server" /><br />
            
            </div>
            <div class="column">
                <b>Election Management</b><br />
                <a href="approvenominations.aspx">Approve Eligibility</a><br />
                <a href="terminate.aspx">Cancel Election</a><br />
                <a href="slate.aspx"">View current Slate</a><br />
                <a href="removeFromBallot.aspx">Remove Candidate(s) From Slate</a>
                <br />
            </div>
        </asp:Panel>
        <div class="clear"></div>
    
        <!--The petition functionality will be active during this phase.-->
        <div id="special">
        
            <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Conditional">
            <Triggers>
            <asp:PostBackTrigger ControlID="ButtonSubmit" />
            </Triggers>
            <ContentTemplate>

            <br />
            Search for the individual you would like to submit a petition for:<br />
            <asp:TextBox ID="txtSearch" runat="server" Width=300></asp:TextBox> 
            <asp:Button ID="btnSearch"  runat="server" Text="Search" OnClick="search" /> 
            <asp:LinkButton ID="btnViewAll"   runat="server" Text="Clear" OnClick="clear" Visible="false" /> <br /><br />
            <span style="color: Blue"><asp:Label ID="LabelFeedback" runat="server" Text="" /></span><br />

                <table class="simpleGrid" style="width: 60%">
                    <tr>
                        <th>Full Name</th>
                        <th>Department</th>
                        <th></th>
                    </tr>
                    <asp:ListView ID="ListViewUsers" Visible="false" OnItemCommand="ListViewUsers_ItemCommand" runat="server">
                        <LayoutTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td >
                                    <asp:Label ID="LabelName" text='<%#Eval("last_name") + ", " + Eval("first_name") %>' runat="server" />
                                </td>
                                <td >
                                    <asp:Label ID="Label1" text='<%#Eval("department") %>' runat="server" />
                                </td>
                                <td >
                                   <asp:Button ID="ButtonNominate" 
                                       commandname="nominate"
                                       commandargument='<%#Eval("idunion_members") %>' 
                                       text="Submit Petition" runat="server" />                
                                </td>
                            </tr>
                         </ItemTemplate>
                    </asp:ListView>
                </table>
            </ContentTemplate>
                    </asp:UpdatePanel>

                <asp:Panel ID="PanelChoosePosition" CssClass="modalPopup" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="LabelChoosPosition" runat="server" Text="" /><br /><br />
                            <asp:HiddenField ID="HiddenFieldName" runat="server" />
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:DropDownList ID="DropDownListPostions" runat="server">
                            </asp:DropDownList><br /> <br />
                            <asp:Button ID="ButtonSubmit" runat="server" OnClick="ButtonSubmit_Clicked" Text="Submit Your Petition" />
                            <asp:Button ID="ButtonCancel" runat="server" OnClick="ButtonCancel_Clicked" Text="Cancel" />
                         </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>

                <asp:Button ID="Button1" runat="server" Text="" style="display: none" />

                <asp:ModalPopupExtender ID="PopupControlExtender1" runat="server"
                    TargetControlID="Button1"
                    PopupControlID="PanelChoosePosition"
                    CancelControlID="ButtonCancel"
                    BackgroundCssClass="modalBackground"
                    PopupDragHandleControlID="PanelChoosePosition"
                />
        </div>


    </asp:Panel>
    <!--End Petition-->

    <!--Acceptance 2 phase-->
    <asp:Panel ID="lblAccept2" Enabled="false" Visible="false" runat="server">
        <div id="bodyCopy">
                <h1>Petition Acceptance Period</h1>
                The current election is in a petition acceptance period.  This period acts as a buffer to give extra time to accept petition-based nominations.
            </div>

            <!--Admin only-->
            <asp:Panel id="functions_accept2" style="margin-top:10px;" visible="false" runat="server">
                <div class="column">
                    <b>User Management</b><br />
                    <asp:LinkButton ID="LinkButton13"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                                text="Create User" runat="server" /><br />
                    <asp:LinkButton ID="LinkButton14"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                                text="Edit User" runat="server" /><br />
            
                </div>
                <div class="column">
                    <b>Election Management</b><br />
                    <a href="approvenominations.aspx">Approve Eligibility</a><br />
                    <a href="terminate.aspx">Cancel election</a>
                    <br />
                </div>
            </asp:Panel>
        

            <div class="clear"></div>
    
            </div>
    </asp:Panel>

    <!--end acceptance 2-->

    <!--Approval-->
        <!--Only admin will see this phase-->
        <asp:Label ID="lblApproval" runat="server" Enabled="false" Visible="false">
            <div id="bodyCopy">
                <h1>Eligibility Approval Period</h1>
                This is a special phase that will end as soon as all eligibility forms have been approved or disapproved.
            </div>

            <!--Admin only-->
            <asp:Panel id="functions_approval" style="margin-top:10px;" visible="false" runat="server">
                <div class="column">
                    <b>User Management</b><br />
                    <asp:LinkButton ID="LinkButton15"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                                text="Create User" runat="server" /><br />
                    <asp:LinkButton ID="LinkButton16"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                                text="Edit User" runat="server" /><br />
            
                </div>
                <div class="column">
                    <b>Election Management</b><br />
                    <a href="approvenominations.aspx">Approve Eligibility</a><br />
                    <a href="terminate.aspx">Cancel election</a><br />
                    <a href="removeFromBallot.aspx">Remove Candidate(s) From Slate</a>
                    <br />
                </div>
            </asp:Panel>
        

            <div class="clear"></div>
    

        </asp:Label>
    <!--End Approval-->

    <!--Voting-->
    <asp:Panel ID="lblVoting" Enabled="false" visible="false" runat="server">

        <div id="bodyCopy">
            <h1>Voting Period</h1>
            The current election is in the voting phase.  You must vote for the candidate you feel will best serve in each position.
        </div>
        <asp:Panel id="functions_voting" style="margin-top:10px;" visible="false" runat="server">
            <div class="column">
                <b>User Management</b><br />
                <asp:LinkButton ID="LinkButton11"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                            text="Create User" runat="server" /><br />
                <asp:LinkButton ID="LinkButton12"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                            text="Edit User" runat="server" /><br />
            
            </div>
            <div class="column">
                <b>Election Management</b><br />
                <a href="terminate.aspx">Cancel election</a><br />
                <a href="removeFromBallot.aspx">Remove Candidate(s) From Slate</a>
            </div>
        </asp:Panel>
        <div class="clear"></div>
    
        <!--The voting functionality will be available for this phase-->
        <div id="special">
        <br />
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div style="color: Blue; padding-bottom: 6px;"><asp:Label ID="LabelFeedbackVote2" runat="server" Text="To begin the voting process, please select a position from the list below"></asp:Label></div>
            
                <asp:Panel ID="PanelSlateWrapper" runat="server">
                    <div id="slateWrapper" style="width: 710px; height: 385px; background-color: #FF9999;">
                        <!-- Holds the positions in the election -->
                        <asp:Panel ID="PanelPositions" CssClass="slateListPositions" runat="server">
                            <asp:ListView ID="ListViewPositions"  OnItemCommand="ListViewPositions_ItemCommand" runat="server">
                                <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                </LayoutTemplate>
                                <ItemTemplate>
                                        <asp:LinkButton ID="LinkButtonPostions" CssClass="bold" runat="server" CommandName="position" CommandArgument='<%#Eval("position")%>' Text='<%#Eval("position")%>' /><br />
                                    <span style="font-size: 12px; font-weight: bold; color: #808080">
                                        <asp:Label ID="LabelVotedExtra" runat="server" Text=""></asp:Label>
                                        <asp:Label ID="LabelVoted" runat="server" Text=""></asp:Label>
                                        <asp:HiddenField ID="HiddenFieldVotedId" runat="server" />
                                        <asp:HiddenField ID="HiddenFieldVoteNumber" Value='<%#Eval("votes_allowed")%>' runat="server" />
                                        <asp:HiddenField ID="HiddenFieldAllCandidates" Value="" runat="server" />
                                    </span>
                                    <hr />
                                </ItemTemplate>
                            </asp:ListView>
                        </asp:Panel>
                        <!-- Holds the people nominated for each position -->
                        <asp:Panel ID="PanelPeople" CssClass="slateListPeople" Visible="false" runat="server">
                            <asp:ListView ID="ListViewPeople" OnItemCommand="ListViewPeople_ItemCommand" runat="server">
                                 <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButtonPostions" runat="server" CssClass="bold" CommandName="id" CommandArgument='<%#Eval("idunion_members")%>' Text='<%#Eval("fullname")%>' /><br /><hr />
                                </ItemTemplate>
                            </asp:ListView>
                        </asp:Panel>
                        <!-- Holds submit button and the info that belows to that persion -->
                        <asp:Panel ID="PanelSelect" CssClass="slateDetailPeople" Visible="false" runat="server">
                            <br />
                            <div style="margin-right: auto; margin-left: auto; width: 290px; text-align: center;"><asp:Button ID="ButtonVote" OnClick="ButtonVote_Clicked" runat="server" Text="Vote for This Person" /></div>
                            <br />
                            <span style="text-decoration: underline; font-weight: bolder">
                                Their Personal Statement:
                            </span>
                            <br />
                            <div style="overflow: auto; width: 280px; height: 290px;">
                                <asp:Label ID="LabelStatement" runat="server" Text="" />
                            </div>
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:HiddenField ID="HiddenField3" runat="server" />
                        </asp:Panel>
                    </div>
                    <br />
                    <div style="width: 100%; text-align:center;">
                        <asp:Button ID="ButtonSubmitVotes" Visible="false" runat="server" OnClick="ButtonSubmitVotes_Clicked" Text="Submit Your Completed Ballot For Processing" />
                    </div>
                    <br />
                    <asp:HiddenField ID="HiddenFieldCurrentPosition" runat="server" />
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </asp:Panel>   
    <!--End Voting-->

    <!--Results-->
    <asp:Panel ID="lblResults" Visible="false" Enabled="false" style="text-align: center;" runat="server">
            <h1>Results of the Election</h1><br />
            
            <asp:GridView ID="resultList" CssClass="simpleGrid" OnRowCommand="resultList_RowCommand" style="margin-left: auto; margin-right: auto;" AutoGenerateColumns="false" runat="server">
            <Columns>
                <asp:BoundField HeaderText="Position" DataField="position" />
                <asp:BoundField HeaderText="Winner" DataField="fullname" />
                <asp:TemplateField HeaderText="" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonPositionDetail" commandname="position"  commandargument='<%#Eval("position") %>' text="View Position Result Data" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            </asp:GridView>

            <center><br />
            <asp:Label ID="necApprove" runat="server" Text="<b>Please approve the results above from this past election.</b>" Enabled="false" Visible="false" /><br />
            <asp:Button ID="necButton" runat="server" Text="Approve" Visible="false" Enabled="false" OnClick="necButton_OnClick" />
            <asp:Label ID="adminEnd" runat="server" Text="<b>The NEC must approve the election results before you can end the current election.</b>" Enabled="false" Visible="false" /><br />
            <asp:Button ID="adminButton" runat="server" Text="Offically End This Election" Visible="false" Enabled="false" OnClick="adminButton_OnClick" />
            </center>
    
    </asp:Panel>
    <!--End Results-->

    <!--Admin Error Section-->
    <!--For fatal election errors only-->
    <asp:Panel ID="lblAdminError" Enabled="false" Visible="false" runat="server">
        <asp:Label ID="lblError" runat="server" />
        <asp:Button ID="fatalError" OnClick="fatalError_ButtonClick" Text="Delete Election" runat="server" />
    </asp:Panel>

    <!--End Admin Error Section-->

    <!--General Error-->
    <asp:Panel ID="lblGeneralError" Enabled="false" Visible="false" runat="server">
        <asp:Label ID="lblGError" runat="server">
            A fatal error has occurred with the election.  Please contact the administrator.
        </asp:Label>
    </asp:Panel>
    <!--End General Error-->

    <!--Stateless-->
    <asp:Panel ID="lblStateless" Enabled="false" Visible="false" runat="server">
        <div id="bodyCopy">
            <h1>No Current Activity</h1>
            There are currently no active election phases.  This could mean that there is no election running, or that there is no 
            action required on your part at this time.
        </div>
        <asp:Panel id="functions_stateless" style="margin-top:10px;" visible="false" runat="server">
            <div class="column">
                <b>User Management</b><br />
                <asp:LinkButton ID="LinkButton9"  commandname="id" CommandArgument="Register.aspx"  OnCommand="transfer"
                            text="Create User" runat="server" /> <br />
                <asp:LinkButton ID="LinkButton10"  commandname="id" CommandArgument="users.aspx"  OnCommand="transfer"
                            text="Edit User" runat="server" /><br />
            </div>
            <div class="column">
                <b>Election Management</b><br />
                <a href="controlRoom.aspx">Create Election</a><br />
            </div>
        </asp:Panel>
        <div class="clear"></div>
    </asp:Panel>
    <!--End Stateless-->
</asp:Content>

