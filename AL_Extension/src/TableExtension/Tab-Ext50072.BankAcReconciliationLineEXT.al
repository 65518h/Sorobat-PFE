TableExtension 50072 "Bank Ac.Reconciliation LineEXT" extends "Bank Acc. Reconciliation Line"
{
    fields
    {

        modify(Difference)
        {
            trigger OnBeforeValidate()
            begin
                //+RAP+RAPPRO
                IF ("Bank Description" <> '') AND gAddOnLicencePermission.HasPermissionRAP() THEN
                    "Statement Amount" := xRec."Statement Amount"
                //GL2024  ELSE
                //+RAP+RAPPRO// 
            end;
        }

        field(50000; "Lettré"; Boolean)
        {
            Description = 'HOSNI SORO 20-09-2016';
        }
        field(50001; Sequence; Integer)
        {
            Description = 'HOSNI SORO 20-09-2016';
        }
        field(8001402; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(8001403; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor;
        }
        field(8001404; "Source Bank Account No."; Code[20])
        {
            Caption = 'Source Bank Account No.';
            TableRelation = if ("Source Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Source No."))
            else
            if ("Source Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Source No."));
        }
        field(8001406; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            OptionCaption = ' ,Not Accepted,Accepted,BOR';
            OptionMembers = " ","Not Accepted",Accepted,BOR;
        }
        field(8001600; "Bank Description"; Text[50])
        {
            Caption = 'Bank Description';
            Description = '#8866';
        }
        field(8001601; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(8001621; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(8001625; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
    }
    keys
    {

        /*  GL2024  key(STG_Key3;"Bank Account No.","Statement No.","Due Date")
            {
            SumIndexFields = "Statement Amount",Difference;
            }

            key(STG_Key4;"Bank Account No.","Statement No.","Lettré")
            {
            SumIndexFields = "Statement Amount",Difference;
            }*/
    }


    trigger OnAfterDelete()
    VAR
        lBARMgt: Codeunit "BAR Management";
    begin
        //+RAP+RAPPRO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            lBARMgt.DeleteBankAccReconciliation(Rec, COMPANYNAME);
        //+RAP+RAPPRO//

    end;


    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
}

