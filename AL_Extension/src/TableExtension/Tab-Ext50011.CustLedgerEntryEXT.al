TableExtension 50011 "Cust. Ledger EntryEXT" extends "Cust. Ledger Entry"
{
    fields
    {

        modify("Due Date")
        {

            trigger OnbeforeValidate()
            var

                lBARMgt: Codeunit "BAR Management";
            begin

                //+RAP+TRESO
                IF gAddOnLicencePermission.HasPermissionRAP THEN
                    lBARMgt.SetValueDate2CLE(Rec);
                //+RAP+TRESO//
            end;
        }
        /* field(50000; Avance; Boolean)
         {
             CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
             Description = 'RB SORO 27/03/2015';
             FieldClass = FlowField;
         }*/
        field(50001; "Code Lettrage"; Text[3])
        {
            Description = 'HJ SORO 11-04-2015';
        }
        field(50002; "Folio No"; Text[20])
        {
        }
        field(50003; Lettre; Text[4])
        {
            Description = 'HJ SORO 03-05-2015';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Masque Code';
            TableRelation = Mask;
        }
        field(3010831; "LSV No."; Integer)
        {
            Caption = 'LSV No.';
            TableRelation = "LSV Journal";
        }
        field(8001400; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(8003900; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004040; "Retention Code"; Code[10])
        {
            Caption = 'Retention Code';
            TableRelation = Retention;
        }
        field(8004041; "Retention %"; Decimal)
        {
            Caption = 'Retention %';
            Editable = true;
        }
    }
    keys
    {
        key(STG_Key37; "Customer No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
        key(STG_Key38; "Customer No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Due Date")
        {
        }
        key(STG_Key39; "Customer No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Posting Date")
        {
        }
        //GL2024
        /*  key(STG_Key40; Open, "Value Date")
          {
          }
          key(STG_Key41; "Job No.", "Customer No.", Open, Positive, "Due Date", "Currency Code")
          {
          }
          key(STG_Key42; "Document Type", "Document No.", "Retention Code", "Job No.", "Open")
          {
          }
          key(STG_Key43; "Document No.", "Document Type", "Customer No.")
          {
          }
          key(STG_Key44; "LSV No.", "Customer No.")
          {
          }*/
        key(STG_Key45; "Source Code", "Posting Date")
        {
        }
        key(STG_Key46; "Lettre")
        {
        }



    }

    var

        gAddOnLicencePermission: Codeunit IntegrManagement;
}

