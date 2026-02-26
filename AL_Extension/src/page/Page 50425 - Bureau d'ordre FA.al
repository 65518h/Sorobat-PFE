namespace Microsoft.Purchases.Document;

using Microsoft.EServices.EDocument;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Attachment;
using Microsoft.Foundation.Reporting;
using Microsoft.Purchases.Comment;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Utilities;
using System.Automation;
using System.Environment.Configuration;
using System.Integration.PowerBI;
using System.Text;
using System.Threading;
page 50425 "Bureau Ordre FA"
{
    AdditionalSearchTerms = 'Vendor Invoices, Procurement Invoices, Vendor Bills, Purchase Bills, Supplier Invoices, Acquisition Bills, Buying Invoices, Supplier Bill List, Invoice Purchase Log, Merchant Invoices, Trade Invoices';
    ApplicationArea = Basic, Suite;
    Caption = 'Entrée Bureau d''ordre';
    DataCaptionFields = "Buy-from Vendor No.";
    PageType = List;
    QueryCategory = 'Purchase Invoices';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Invoice), "Entree Bureau Ordre" = const(true));
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ShowMandatory = true;
                }

                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    Editable = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                    ShowMandatory = true;
                }
                field("Montant Total"; Rec."Montant Total") { ApplicationArea = all; StyleExpr = true; Style = Favorable; }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                    Visible = false;
                }
                field("Date Bureau Ordre"; Rec."Date Bureau Ordre")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                    ShowMandatory = true;
                }

            }
        }
        area(factboxes)
        {
            part(AttachedDocuments; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }

            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }

            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    { }

    trigger OnAfterGetRecord()
    begin
        StatusStyleTxt := Rec.GetStatusStyleText();
    end;

    trigger OnAfterGetCurrRecord()
    var
        FilteredPurchaseHeader: Record "Purchase Header";
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        CurrPage.SetSelectionFilter(FilteredPurchaseHeader);

    end;

    trigger OnInit()
    begin

    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        Rec.CopyBuyFromVendorFilter();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Entree Bureau Ordre" := true;
        rec."Date Bureau Ordre" := today;
    end;

    var
        OpenPostedPurchaseInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Purchase Invoice window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';
        ReportPrint: Codeunit "Test Report-Print";
        PowerBIServiceMgt: Codeunit "Power BI Service Mgt.";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ReadyToPostQst: Label 'The number of invoices that will be posted is %1. \Do you want to continue?', Comment = '%1 - selected count';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        StatusStyleTxt: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    procedure Post(PostingCodeunitID: Integer)
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
        IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

        Rec.SendToPosting(PostingCodeunitID);

        IsHandled := false;
        OnPostBeforeNavigateAfterPosting(Rec, PostingCodeunitID, IsHandled);
        if IsHandled then
            exit;

        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.")
        else
            PurchInvHeader.SetRange("Pre-Assigned No.", PreAssignedNo);

        if PurchInvHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Invoices");
    end;

    procedure VerifyTotal(PurchaseHeader: Record "Purchase Header")
    begin
        if not PurchaseHeader.IsTotalValid() then
            Error(TotalsMismatchErr);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnPostBeforeNavigateAfterPosting(var PurchaseHeader: Record "Purchase Header"; var PostingCodeunitID: Integer; var IsHandled: Boolean)
    begin
    end;
}

