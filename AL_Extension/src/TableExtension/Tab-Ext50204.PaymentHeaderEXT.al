TableExtension 50204 "Payment HeaderEXT" extends "Payment Header"
{
    fields
    {
        /*GL2024   modify("No.")
           {
               Editable = true;
           }
           modify("Amount (LCY)")
           {
               DecimalPlaces = 3 : 3;
           }

           modify(Amount)
           {
               DecimalPlaces = 3 : 3;
           }*/

        modify("Status No.")
        {
            trigger OnAfterValidate()
            var
                PaymentStep: Record "Payment Step";
            begin
                PaymentStep.SETRANGE("Payment Class", "Payment Class");
                PaymentStep.SETFILTER("Next Status", '>%1', "Status No.");
                PaymentStep.SETRANGE(PaymentStep."Action Type", PaymentStep."Action Type"::Ledger);
                // >> HJ DSFT 02 JUILLET 2010
                IF RecG_BankAccount.GET("Account No.") THEN
                    "Source Code" := RecG_BankAccount."Source code";
                // >> HJ DSFT 02 JUILLET 2010
                // >> HJ DSFT 02 JUILLET 2010
                /*    { STD HJ DSFT 02 JUILLET 2010 IF PaymentStep.FIND('-') THEN
                "Source Code" := PaymentStep."Source Code";  }*/
            end;
        }

        modify("Account Type")
        {
            trigger OnAfterValidate()
            begin
                // STD V2.00
                CLEAR(RecGPaymentStatus);
                IF RecGPaymentStatus.GET("Payment Class", "Status No.") THEN;
                RegLine.RESET;
                RegLine.SETRANGE("No.", "No.");
                IF RegLine.FIND('-') THEN
                    RegLine.MODIFYALL("Header Account Type", "Account Type");
                // STD V2.00
            end;
        }

        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin

                if "Account Type" = "Account Type"::"Bank Account" then begin
                    if CompanyBankAccount.Get("Account No.") then begin
                        //GL2024   "Bank Branch No." := CompanyBankAccount."Nom Banque Etat";
                        "Bank Branch No." := CompanyBankAccount."Bank Branch No.";
                        "Agency Code" := CompanyBankAccount.Agence;
                    end;
                end;


                // STD V2.00
                CLEAR(RecGPaymentStatus);
                IF RecGPaymentStatus.GET("Payment Class", "Status No.") THEN;
                RegLine.RESET;
                RegLine.SETRANGE("No.", "No.");
                IF RegLine.FIND('-') THEN
                    RegLine.MODIFYALL("Header Account Type", "Account Type");

                // RegLine.RESET;
                // RegLine.SETRANGE("No.", "No.");
                // IF RecG_BankAccount.GET("Account No.") THEN;
                // IF RegLine.FIND('-') THEN
                //     RegLine.MODIFYALL(Banque, RecG_BankAccount.Banque);

                // STD V2.0


                //>>MZK 24/12/09
                //qd on saisi le Nø compte bancaire, insertion du code jouranl correspondant otomatiqment
                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    IF RecG_BankAccount.GET("Account No.") THEN;
                    "Source Code" := RecG_BankAccount."Source code";
                END;
                //<<MZK 24/12/09


            end;
        }

        field(50000; "N° Bordereau"; Code[20])
        {
            Description = 'STD V.10';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStatus);
                if RecGPaymentStatus.Get("Payment Class", "Status No.") then;

                RegLine.Reset;
                RegLine.SetRange("No.", "No.");
                if RegLine.Find('-') then begin
                    RegLine.ModifyAll("N° Bordereau", "N° Bordereau");
                end;
                //>>DSFT-TRIUM 01/06/09
            end;
        }
        field(50001; "Date Création"; DateTime)
        {
            Description = 'STD V.10';
            Editable = false;
        }
        field(50002; "Créer par"; Code[20])
        {
            Description = 'STD V.10';
            Editable = true;
        }
        field(50003; "Modifié le"; DateTime)
        {
            Description = 'STD V.10';
            Editable = false;
        }
        field(50004; "Modifié par"; Code[50])
        {
            Description = 'STD V.10';
            Editable = true;
        }
        field(50005; Caisse; Boolean)
        {
            Description = 'STD V.10';
        }
        field(50006; "Type paiement"; Option)
        {
            Description = 'STD V.10';
            Editable = true;
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;

            trigger OnValidate()
            begin
                RegLine.SetRange("No.", "No.");
                if RegLine.FindFirst then
                    repeat
                        RegLine."Type paiement" := RegLine."type paiement"::Avance;
                    until RegLine.Next = 0;
            end;
        }
        field(50007; "Bénéficiaire"; Text[50])
        {
            Description = 'STD V.10';
        }
        field(50008; "Qualité"; Text[50])
        {
            Description = 'STD V.10';
        }
        field(50009; Objet; Option)
        {
            Description = 'STD V.10';
            OptionCaption = ' ,Déplacement,Avance,Prêt,Réglement facture,Divers';
            OptionMembers = " ","Déplacement",Avance,"Prêt","Réglement facture",Divers;
        }
        field(50010; Justificatifs; Option)
        {
            Description = 'STD V.10';
            OptionCaption = ' ,Facture,Ordre de mission';
            OptionMembers = " ",Facture,"Ordre de mission";
        }
        field(50011; "Nombre Impression"; Integer)
        {
            Description = 'STD V.10';
        }
        field(50012; Provisoire; Boolean)
        {
            Description = 'STD V.10';
        }
        field(50015; "Nom Tiers"; Text[80])
        {
            CalcFormula = lookup("Payment Line".Libellé where("No." = field("No.")));
            Description = 'STD V.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; Presentation; Option)
        {
            Description = 'bsk 220311';
            OptionCaption = ' ,2eme Presentation,Bon A Payer,Lettre De Reconstitution';
            OptionMembers = " ","2eme Presentation","Bon A Payer","Lettre De Reconstitution";
        }
        field(50020; "N° CI"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50021; "DATE D'EMBARQUEMENT"; Date)
        {
            Description = 'BSK LC';
        }
        field(50022; "DATE D'EXPIRATION"; Date)
        {
            Description = 'BSK LC';
        }
        field(50023; "CONDITION DE VENTE"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50024; "PORT EMBARQUEMENT"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50025; "PORT DEBARQUEMENT"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50026; "Mode Echéance"; Option)
        {
            Description = 'BSK LC';
            OptionCaption = 'A VUE,120J DATE BL,90J DATE BL,60J DATE BL,45JJ DATE BL,30J DATE BL';
            OptionMembers = "A VUE","120J DATE BL","90J DATE BL","60J DATE BL","45JJ DATE BL","30J DATE BL";
        }
        field(50027; "Objet Lettre"; Text[250])
        {
            Description = 'BSK LC';
        }
        field(50028; "N° Brouillard"; Text[250])
        {
            Description = 'BSK LC';
        }
        field(50029; Destinataire; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50030; TAUX; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50031; "Durée"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50032; "Comm Bancaire"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50033; "Période"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50034; "Tomber FED"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50035; "ABK"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Payment Class".EXT WHERE(Code = FIELD("Payment Class")));

        }
        field(50036; "Mode Paiement"; Option)
        {
            Description = 'HJ SORO 22-12-2014';
            OptionMembers = " ",Cheque,Traite,Espece;
        }
        field(50037; "N° Caisse"; Code[20])
        {
            Description = 'MH SORO 18-04-2017';
        }
        field(50038; "N° Sequence Caisse"; Code[20])
        {
            Description = 'MH SORO 18-04-2017';
        }
        field(50039; "Montant Brouillard"; Decimal)
        {
            Description = 'MH SORO 18-04-2017';
        }
        field(50040; Ecart; Decimal)
        {
            Description = 'MH SORO 18-04-2017';
            FieldClass = Normal;
        }
        field(50041; Motif; Text[100])
        {
            Description = 'MH SORO 10-03-2018';
        }
        field(50042; "Autoriser avance Fournisseur"; Boolean)
        {
            Description = 'MH SORO 04-05-2023';
        }
        field(50043; "Approuvé par"; Code[20])
        {
            Description = 'MH SORO 04-05-2023';
        }
        field(50044; "Date Approbation"; Date)
        {
            Description = 'MH SORO 04-05-2023';
        }
        field(50535; Valider; Boolean)
        {
            Description = 'HJ DSFT 04-10-2012';
        }
        field(50536; Avance; Boolean)
        {
            Description = 'RB SORO 26/03/2015  Pour le decaissment Traite et Cheque de type Avance';
        }
        field(50537; "Modifier Date Compta"; Boolean)
        {
            Description = 'RB SORO 27/08/2015';
        }
        field(50600; Suggestions; Option)
        {
            Caption = 'Suggestions';
            Description = 'STD V.10';
            OptionCaption = 'None,Customer,Vendor,Salary';
            OptionMembers = "None",Customer,Vendor,Salary;
        }
        field(50601; Agence; Code[10])
        {
            Description = 'HJ';
            TableRelation = "Agence";
        }
        field(50602; Utilisateur; Code[30])
        {
            Description = 'HJ';
            Editable = true;
            TableRelation = User;
        }
        field(50603; "Validé Par"; Code[30])
        {
            Description = 'HJ';
        }
        field(50604; "Code Recouvreur"; Code[20])
        {
            Description = 'IBK DSFT 20 08 2010';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50605; "Marché"; Code[20])
        {
            Description = 'HJ DELTA 09-02-2014';
            TableRelation = Job;
        }
        field(50606; "Opération"; Option)
        {
            Description = 'HJ DELTA 09-02-2014';
            OptionMembers = "Contrôles Factures",Appro,Technique;
        }
        field(50607; "Mois Echeance Crédit Bancaire"; Integer)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
        field(50608; "Date Echeance à Comptabiliser"; Date)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
        field(50609; "Solde Caisse Ex"; Decimal)
        {
            Description = 'HJ SORO 16-06-2014';
            Editable = false;
        }
        field(50610; Historique; Boolean)
        {
            Description = 'HJ SORO 16-06-2014';
            Editable = false;
        }
        field(50611; Solde; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount WHERE("Compte Entete" = CONST('CA001001')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50612; Reouvrir; Boolean)
        {
            Description = 'HJ SORO 16-06-2014';
        }
        field(50613; "Solde Caisse"; Decimal)
        {
            CalcFormula = - sum("Payment Line".Amount where(Caisse = const(true)));

            Description = 'HJ SORO 16-06-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50614; "Caisse Chantier"; Boolean)
        {
            Description = 'HJ SORO 12-09-2014';
            Editable = true;
        }
        field(50615; "Solde Caisse Chantier"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = field("N° Affaire"), "Caisse Destination" = const('')));

        }
        field(50616; "Approuver"; Boolean)
        {
            Description = 'HJ SORO 05-02-2015';
        }
        field(50617; "Folio N° RS"; Code[20])
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50618; "N° Contrat"; Code[20])
        {
            Description = 'HJ SORO 20-06-2015';
        }
        /*  field(50619; "Caisse Chantier"; Boolean)
          {
              Description = 'HJ SORO 12-03-2018';
          }*/
        field(50620; "N° Affaire"; Code[20])
        {
            Description = 'MH SORO 20-04-2021';
            TableRelation = Job;
        }
        /*     field(50621; "Solde LOMBELA"; Decimal)
          {
              Caption = 'Solde LOMBELA';
              CalcFormula = - Sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true),
                                                               "N° Affaire" = const('LOMBELA')));

              Editable = false;
              FieldClass = FlowField;
          }
          field(50622; "Solde Caisse1"; Decimal)
          {


              Editable = false;

          }
         field(50622; "Solde Caisse RFR"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('PENETRANTE_LOT2')));
                Description = 'MH SORO 2022';
                Editable = false;
                FieldClass = FlowField;
            }
            field(50623; "Solde Caisse PENETRANTE"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('PENETRANTE_LOT3')));
                Description = 'MH SORO 2022';
                Editable = false;
                FieldClass = FlowField;
            }
            field(50624; "Solde Caisse Bizerte Aerop"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('BIZERTE_BASE_AERIEN')));
                Description = 'MH SORO 2022';
                Editable = false;
                FieldClass = FlowField;
            }
            field(50625; "Solde Caisse Bizerte Lot1"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('PONT_BIZERTE_LOT1')));
                Description = 'MH SORO 2022';
                Editable = false;
                FieldClass = FlowField;
            }
            field(50626; "Solde Caisse RAOUED RP2"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('PORT FINA RAOUED RP2')));
                Description = 'MH SORO 2022';
                FieldClass = FlowField;
            }
            field(50627; "Solde Caisse SBIKHA LOT5"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('AUTOROUTE SBIKHA LO5')));
                Description = 'MH SORO 2023';
                FieldClass = FlowField;
            }
            field(50628; "Solde Caisse KEF RR173"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('CHANTIER_KEF_RR173')));
                Description = 'MH SORO 2023';
                FieldClass = FlowField;
            }
            field(50629; "Solde Caisse JOUMINE"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('OUED_JOUMINE_MATEUR')));
                Description = 'MH SORO 2023';
                FieldClass = FlowField;
            }

            field(50630; "Solde Caisse RFR LOT1"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('RFR LOT1')));
                Description = 'MH SORO 2025';
                FieldClass = FlowField;
            }
            field(50631; "Solde Caisse BOUSSELEM"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('MEDJERDA BOUSALEM')));
                Description = 'MH SORO 2025';
                FieldClass = FlowField;
            }

            field(50632; "Solde Caisse BOUSSADIA"; Decimal)
            {
                CalcFormula = sum("Payment Line".Amount where(Caisse = const(true),
                                                               "Caisse Chantier" = const(false),
                                                               "N° Affaire" = const('RVE719BOUSSADIA')));
                Description = 'MH SORO 2025';
                FieldClass = FlowField;
            }*/


        //GL2024
        field(50633; "Chantier"; Option)
        {
            caption = 'Chantier';
            OptionCaption = ',OACA,PENETRANTE LOT2,PENETRANTE LOT3,BIZERTE BASE AERIEN,BIZERTE PONT LOT1,RAOUED,AUTOR SBIKHA LO5,AUT KEF RR173,OUED JOUMINE MATEUR,MEDJERDA BOUSALEM,RFR LOT1,RVE719BOUSSADIA';
            OptionMembers = "",OACA,"PENETRANTE LOT2","PENETRANTE LOT3","BIZERTE BASE AERIEN","BIZERTE PONT LOT1","RAOUED","AUTOR SBIKHA LO5","AUT KEF RR173","OUED JOUMINE MATEUR","MEDJERDA BOUSALEM","RFR LOT1",RVE719BOUSSADIA;
        }

    }
    keys
    {

        key(STG_Key3; "Payment Class", "Status No.", "No.")
        {
        }
        key(STG_Key4; "N° Bordereau")
        {
        }
        key(STG_Key5; "Créer par")
        {
        }
    }

    trigger OnAfterInsert()
    var

    begin

        if Process.get(rec."Payment Class") then begin
            //>> HJ SOROT 16-06-2014
            IF Process.EXT THEN BEGIN
                "Account Type" := "Account Type"::"Bank Account";
                VALIDATE("Account No.", Process."Caisse Par Defaut");
            END;
        end;
        //>> HJ SOROT 16-06-2014

        // STD V2.00
        "Date Création" := CURRENTDATETIME;
        "Créer par" := COPYSTR(USERID, 1, 20);
        // STD V2.00


    end;

    trigger OnModify()
    begin
        // STD V2.00
        "Modifié le" := CURRENTDATETIME;
        "Modifié par" := USERID;
        // STD V2.00
    end;




    procedure CaisseExCpt(ParaCaisse: Text[1])
    begin
        GCaisse := ParaCaisse;
    end;

    procedure GetNoSeries("ParaTypeRéglement": Text[30])
    var
        RecLPaymentClass: Record "Payment Class";
    begin
        //>> HJ DSFT 22-09-2011
        if RecLPaymentClass.Get(ParaTypeRéglement) then;
        NoSeriesMgt.InitSeries(RecLPaymentClass."Header No. Series", xRec."No. Series", 0D, "No.", "No. Series");
        InitHeader2;
        //>> HJ DSFT 22-09-2011
    end;


    //GL2024 crée procedure spécifque pour utilise dans tableEXT, car le méme procedure est local dans le code standard 
    procedure InitHeader2()
    begin
        "Posting Date" := WorkDate();
        "Document Date" := WorkDate();
        Validate("Account Type", "Account Type"::"Bank Account");
    end;
    //GL2024 FIN



    var
        UserSetup: Record "User Setup";
        PaymentLine: Record "Payment Line";
        SoldeAffaire: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "//DSFT-TRIUM": Text[30];
        RecGPaymentStatus: Record "Payment Status";
        "//MZK": Integer;
        RecG_BankAccount: Record "Bank Account";
        RecAutorisationTypesRegelement: Record "Autorisation Types Réglement";
        ProcessTemp: Record "Payment Class";
        GCaisse: Text[1];
        DateDocument: Date;
        Text009: label 'Veuillez Preciser La Date Document';
        MaBoite: Dialog;
        nombre: Integer;
        BankAccount: Record "Bank Account";
        "// RB SORO 27/08/2015": Integer;
        //   RecDetailPaieCaisse: Record "Detail Paie Caisse";
        RegLine: Record "Payment Line";
        CompanyBankAccount: Record "Bank Account";
        Process: Record 10860;


}

