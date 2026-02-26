TableExtension 50088 "Purchases & Payables SetupEXT" extends "Purchases & Payables Setup"
{
    fields
    {
        modify("Default Posting Date")
        {
            Caption = 'Default Posting Date';
        }
        field(50004; "N° dossier"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Dechargement Srv Controle"; Code[20])
        {
            Caption = 'Blanket Order Nos.';
            TableRelation = "No. Series";
        }
        field(50006; "Dechargement Srv Comptable"; Code[20])
        {
            Caption = 'Blanket Order Nos.';
            TableRelation = "No. Series";
        }
        field(50007; "Dechargement Srv Finance"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50008; "Dechargement Avoir Srv Compta"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50025; "Requisition Nos."; Code[10])
        {
            Caption = 'Requisition Nos.';
            TableRelation = "No. Series";
        }
        field(50026; "Modele Feuille DA"; Code[20])
        {
            Description = '// DSFT';
            TableRelation = "Req. Wksh. Template";
        }
        field(50029; "Nom feuille DA"; Code[20])
        {
            Description = '// DSFT';
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("Modele Feuille DA"));
        }
        field(50030; GrandFamCom; Boolean)
        {
        }
        field(50031; FamilleCom; Boolean)
        {
        }
        field(50036; "Critaire 1"; Option)
        {
            Description = 'AGA DSFT 12 07 2010';
            OptionCaption = 'Prix,Delai,Note';
            OptionMembers = Prix,Delai,Note;

            trigger OnValidate()
            begin
                "Critaire 2" := 0;
                "Critaire 3" := 0;
                Modify
            end;
        }
        field(50037; "Critaire 2"; Option)
        {
            Description = 'AGA DSFT 12 07 2010';
            OptionCaption = 'Prix,Delai,Note';
            OptionMembers = Prix,Delai,Note;

            trigger OnValidate()
            begin
                case "Critaire 1" of
                    0:
                        begin
                            if "Critaire 2" = 0 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));
                        end;
                    1:
                        begin
                            if "Critaire 2" = 1 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));

                        end;
                    2:
                        begin
                            if "Critaire 2" = 2 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));

                        end;
                end;


                case "Critaire 3" of

                    1:
                        begin
                            if "Critaire 2" = 1 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 2"));
                        end;
                    2:
                        begin
                            if "Critaire 2" = 2 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 2"));
                        end;
                end;
            end;
        }
        field(50039; "Critaire 3"; Option)
        {
            Description = 'AGA DSFT 12 07 2010';
            OptionCaption = 'Prix,Delai,Note';
            OptionMembers = Prix,Delai,Note;

            trigger OnValidate()
            begin
                case "Critaire 1" of
                    0:
                        begin
                            if "Critaire 2" = 0 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));
                            if "Critaire 3" = 0 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 1"));
                        end;
                    1:
                        begin
                            if "Critaire 2" = 1 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));
                            if "Critaire 3" = 1 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 1"));
                        end;
                    2:
                        begin
                            if "Critaire 2" = 2 then
                                Error('Critaire 2 ne doit pas etre ' + Format("Critaire 1"));
                            if "Critaire 3" = 2 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 1"));
                        end;
                end;
                case "Critaire 2" of
                    0:
                        begin
                            if "Critaire 3" = 0 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 2"));
                        end;
                    1:
                        begin
                            if "Critaire 3" = 1 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 2"));
                        end;
                    2:
                        begin
                            if "Critaire 3" = 2 then
                                Error('Critaire 3 ne doit pas etre ' + Format("Critaire 2"));
                        end;
                end;
            end;
        }
        field(50054; "Enable Approval Requisition"; Boolean)
        {
        }
        field(50055; "Transit File Nos."; Code[10])
        {
            Caption = 'N° Dossier d''import';
            Description = 'STD V1.00';
            TableRelation = "No. Series";
        }
        field(50056; "Groupe Compta Marche TVA"; Code[20])
        {
            TableRelation = "VAT Business Posting Group";
        }

        field(50057; "Autoriser Approbation DA"; Boolean)
        {
            Description = 'RB SORO 21/04/2015';
        }
        field(50058; "Activer Controle Marché"; Boolean)
        {
            Description = 'HJ SORO 06-03-2018';
        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50101; "Purchase Request Nos."; code[20])
        {
            Caption = 'Purchase Request Nos.';
            TableRelation = "No. Series";
        }
        field(50156; "Lien Externe"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50157; "Lien Interne"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50158; "management controller 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50059; "management controller 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50060; "management controlleractivated"; Boolean)
        {
            Caption = 'activated management controller';
            DataClassification = ToBeClassified;
        }
        field(50061; "Envoyer Mail DA"; Boolean)
        {
            Description = 'RB SORO 21/04/2015';
        }
        field(50062; "Durée Suppression Fichier"; DateFormula)
        {
            Caption = 'Durée suppression fichier';
            DataClassification = ToBeClassified;
        }

        field(8002000; "Note of Expenses Nos."; Code[10])
        {
            Caption = 'Note of Expenses Nos.';
            TableRelation = "No. Series";
        }
        field(8002001; "Posted Note of Expenses Nos."; Code[10])
        {
            Caption = 'Posted Note of Expenses Nos.';
            TableRelation = "No. Series";
        }
        field(8004160; "Archive Orders2"; Boolean)
        {
            Caption = 'Archive Orders';
        }
        field(8004161; "Vendor Shipment No. Mandatory"; Boolean)
        {
            Caption = 'Vendor Shipment No. Mandatory';
        }
        field(8004162; "Archiving Method"; Option)
        {
            Caption = 'Archiving Method';
            Description = '#8609';
            InitValue = Standard;
            OptionCaption = 'Standard,At the invoicing,Both';
            OptionMembers = Standard,"At the invoicing",Both;
        }
    }
}

