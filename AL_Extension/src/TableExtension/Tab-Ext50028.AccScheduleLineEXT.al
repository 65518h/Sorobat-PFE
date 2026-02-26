TableExtension 50028 "Acc. Schedule LineEXT" extends "Acc. Schedule Line"
{
    fields
    {



        field(50000; "Filtre département"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50001; "Filtre dossier"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50002; "Totalisation débiteur"; Text[250])
        {
            TableRelation = if ("Totaling Type" = const("Posting Accounts")) "G/L Account"
            else
            if ("Totaling Type" = const("Total Accounts")) "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                case "Totaling Type" of
                    "totaling type"::"Posting Accounts", "totaling type"::"Total Accounts":
                        CpteGL.CalcFields(Balance);
                    "totaling type"::Formula:
                        LigTabAna.SetFilter(LigTabAna."Row No.", LigTabAna.Totaling);
                end;
            end;
        }
        field(50003; "Totalisation créditeur"; Text[250])
        {
            TableRelation = if ("Totaling Type" = const("Posting Accounts")) "G/L Account"
            else
            if ("Totaling Type" = const("Total Accounts")) "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                case "Totaling Type" of
                    "totaling type"::"Posting Accounts", "totaling type"::"Total Accounts":
                        CpteGL.CalcFields(Balance);
                    "totaling type"::Formula:
                        LigTabAna.SetFilter(LigTabAna."Row No.", LigTabAna.Totaling);
                end;
            end;
        }
        field(50004; "Signe calcul"; Option)
        {
            OptionMembers = Normal,"Opposé";
        }
        field(50005; "Totalisation 2"; Text[250])
        {
            TableRelation = if ("Totaling Type" = const("Posting Accounts")) "G/L Account"
            else
            if ("Totaling Type" = const("Total Accounts")) "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                case "Totaling Type" of
                    "totaling type"::"Posting Accounts", "totaling type"::"Total Accounts":
                        CpteGL.CalcFields(Balance);
                    "totaling type"::Formula:
                        LigTabAna.SetFilter(LigTabAna."Row No.", LigTabAna.Totaling);
                end;
            end;
        }
        field(50006; "Filtre date 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50007; "Type Flux"; Option)
        {
            OptionCaption = ' ,Variation,N,N-1';
            OptionMembers = " ",Variation,N,"N-1";
        }
        field(50008; Note; Code[10])
        {
        }
        field(50009; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset","Partener IC",Salarie;
        }
        field(50010; "Source No."; Text[200])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Type" = const("Fixed Asset")) "Fixed Asset";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50011; "Totalisation auxil debiteur"; Boolean)
        {
        }
        field(50012; "Totalisation auxil crediteur"; Boolean)
        {
        }
        field(50013; "Balise N"; Text[30])
        {
        }
        field(50014; "Balise N-1"; Text[30])
        {
        }
        field(50015; "Concatener Balise N"; Text[30])
        {
        }
        field(50016; "Ligne Vide"; Boolean)
        {
        }
        field(50017; "Code Categorie"; Code[10])
        {
        }
        field(50018; "Code Forme juridique"; Code[10])
        {
        }
        field(50019; "Resultat N"; Code[10])
        {
        }
        field(50020; "Resultat N-1"; Code[10])
        {
        }
        field(50021; "Concatener Balise N-1"; Text[30])
        {
        }
        field(51000; "Description Soroubat"; Text[250])
        {
            Caption = 'Description Soroubat';
        }
    }

    var
        CpteGL: Record "G/L Account";
        LigTabAna: Record "Acc. Schedule Line";
}

