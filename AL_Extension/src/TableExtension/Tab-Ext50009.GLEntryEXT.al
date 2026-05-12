TableExtension 50009 "G/L EntryEXT" extends "G/L Entry"
{
    fields
    {
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }




        /*  modify("Source Type")
          {
              trigger OnAfterValidate()
              var
                  RecVendor: Record Vendor;
                  RecCustomer: Record Customer;
              begin
                  // RB SORO 12/05/2015
                  IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                      RecVendor.GET("Source No.");
                      NOM := RecVendor.Name;
                  END
                  ELSE
                      IF "Source Type" = "Source Type"::Customer THEN BEGIN
                          RecCustomer.GET("Source No.");
                          NOM := RecCustomer.Name;
                      END;
                  // RB SORO 12/05/2015

              end;
          }*/






        field(50001; "Frs"; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Ledger Entry"."Vendor No." WHERE("Vendor No." = FIELD("Source No.")));
        }
        field(50002; Lettre; Text[3])
        {
            Description = 'HJ SORO 09-0-2014';
        }
        field(50020; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 25 03 2012';
        }
        /*  field(50021; Avance; Boolean)
          {
              CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
              Description = 'RB SORO 27/03/2015';
              FieldClass = FlowField;
          }*/
        field(50022; salarie; Code[20])
        {
            Description = 'HJ SORO 06-04-2015';
            TableRelation = Salarier;
        }
        field(50023; "Débiteur clt"; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field("Source No."),
                                                Balance = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50025; "Auxiliaire déb/créd1"; Option)
        {
            OptionCaption = 'Débiteur,Crediteur';
            OptionMembers = "Débiteur",Crediteur;
        }
        field(50026; "Débiteur frs"; Boolean)
        {
            CalcFormula = exist(Vendor where("No." = field("Source No."),
                                              Balance = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50027; "Auxiliaire déb/créd2"; Option)
        {
            OptionCaption = 'Débiteur,Crediteur';
            OptionMembers = "Débiteur",Crediteur;
        }
        field(50031; "Folio N° RS"; Code[20])
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50032; NOM; Text[100])
        {
            Description = 'RB SORO 12/05/2015 NOM DE CLIENT OU NOM DE FOURNISSEUR';
        }
        field(50033; "Date D'echeance"; Date)
        {
            Description = 'RB SORO 16/03/2016';
        }
        field(50034; "Affectation Financiere"; Code[60])
        {
            Description = 'HJ SORO 23-02-2017';
        }
        /* field(50035; "Affectation Client"; Code[20])
          {
              CalcFormula = lookup("Payment Line"."Affectation Client" where("No." = field("Document No.")));
              Description = 'RB SORO 13/07/2017';
              FieldClass = FlowField;
              TableRelation = Customer."No.";
          }
          field(50036; "Nom Client"; Text[50])
          {
              CalcFormula = lookup(Customer.Name where("No." = field("Affectation Client")));
              Description = 'RB SORO 13/07/2017';
              FieldClass = FlowField;
          }*/
        field(50099; "Date D'échéance Ligne"; Date)
        {
            CalcFormula = lookup("Payment Line"."Due Date" where("No." = field("Document No."),
                                                                  "External Document No." = field("External Document No.")));
            Description = 'MH SORO 17-08-2020';
            FieldClass = FlowField;
        }
        field(51000; "External Document No. Soroubat"; Code[50])
        {
            Caption = 'External Document No. Soroubat';
        }
        field(51001; "Nom fournisseur"; text[50])
        {
            Caption = 'Nom fournisseur';
        }
        field(51002; Address; text[100])
        {
            Caption = 'Address';
        }
        field(51003; "Address 2"; text[50])
        {
            Caption = 'Address 2';
        }
        field(51004; "N° identif. intracomm."; text[20])
        {
            Caption = 'N° identif. intracomm.';
        }
        field(51005; "N° séquence TVA"; Integer)
        {
            FieldClass = FlowField;
            editable = false;
            CalcFormula = lookup(
           "G/L Entry - VAT Entry Link"."VAT Entry No."
                WHERE("G/L Entry No." = field("Entry No.")));
        }
        field(51006; "Base TVA"; decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(
           "VAT Entry".Base
                WHERE("Entry No." = FIELD("N° séquence TVA")));
        }







        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8001904; "Subscription Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Subscription Entry No.';
        }
        field(8003500; "Analytical Distribution"; Boolean)
        {
            Caption = 'Analytical Distribution';
        }
    }
    keys
    {

        key(STG_Key22; "G/L Account No.", Letter)
        {
        }
        key(STG_Key23; "Subscription Entry No.")
        {
        }
        //GL2024
        // key(STG_Key24; "Analytical Distribution", "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Job No.", "Source Code", "Business Unit Code", "Posting Date")
        // {
        // }
        key(STG_Key25; "G/L Account No.", "Posting Date", "Document Type")
        {
        }
        key(STG_Key26; "Source No.")
        {
        }
        key(STG_Key27; "Posting Date")
        {
        }
        key(STG_Key28; "Source No.", "G/L Account No.", "Posting Date")
        {
        }
        key(STG_Key29; "Source Code", "Posting Date")
        {
        }
        key(STG_Key30; "G/L Account No.", "Posting Date", "Source Code")
        {
        }
        key(STG_Key31; "Source Type", "Source No.")
        {
        }
        key(STG_Key32; "Applies-to ID")
        {
        }
        key(STG_Key33; "Letter", "Source No.", "External Document No.", "Posting Date", Amount, "G/L Account No.")
        {
        }
        key(STG_Key34; "G/L Account No.", "Source No.")
        {
        }
        key(STG_Key35; "salarie")
        {
        }
        //GL2024
        // key(STG_Key36; "Source No.","Source Type",Lettre,"G/L Account No.")
        // {
        // }
        // key(STG_Key37; "G/L Account No.","Posting Date","Source No.","Entry Type","Auxiliaire déb/créd1","Auxiliaire déb/créd2")
        // {
        // }
    }

    trigger OnAfterInsert()
    var
        vendor: Record Vendor;
    begin
        if "Source Type" = "Source Type"::Vendor then begin
            if vendor.get("Source No.") then begin
                "Nom fournisseur" := vendor.Name;
                Address := vendor.Address;
                "Address 2" := vendor."Address 2";
                "N° identif. intracomm." := vendor."VAT Registration No.";
                // Modify()
            end;
        end;
    end;
}

