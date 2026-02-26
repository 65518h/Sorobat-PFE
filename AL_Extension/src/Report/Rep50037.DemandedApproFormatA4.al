Report 50037 "Demande d'Appro Format A4"
{
    DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Demande d''Appro Format A4.rdlc';
    RDLCLayout = './Layouts/Demande d''Appro Format A4 BF.rdlc';

    dataset
    {
        dataitem("Purchase Request"; "Purchase Request")
        {
            column(DernierIndex; DernierIndex)
            {
            }
            column("DernierVidange"; RecEngin."Dernier Vidange")
            {
            }
            column(User_ID; "UserID")
            {
            }
            column(Choix_1; Choix[1])
            {
            }
            column(Choix_2; Choix[2])
            {
            }
            column(Choix_3; Choix[3])
            {
            }
            column(Choix_4; Choix[4])
            {
            }
            column(SousFamilleEngin; "Sous Famille Engin")
            {
            }
            column(Serial_No_; "Serial No.")
            {
            }

            column(Picture; RecCompInf.Picture) { }

            column(N________Sales_Header___No__; 'N°  ' + "Purchase Request"."No.")
            {
            }
            column(Sales_Header__Sales_Header___Document_Date_; "Purchase Request"."Document Date")
            {
            }
            column(Sales_Header__Sales_Header__Service; "Purchase Request".Service)
            {
            }
            column(Sales_Header__Sales_Header___Requester_ID_; "Purchase Request"."Requester ID")
            {
            }
            column(Sales_Header__Sales_Header___Description_Engin_; "Purchase Request"."Description Engin")
            {
            }
            column(Sales_Header__Sales_Header__Engin_; "Purchase Request"."Engin")
            {
            }
            column(Sales_Header__Sales_Header___User_ID_; "Purchase Request"."User ID")
            {
            }
            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(UserName; RecUser."User ID")
            {
            }
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + Format(CurrReport.PageNo))
            {
            }
            column(Marque_______marque; 'Marque :  ' + marque)
            {
            }
            column(No_Chassis_______chassis; 'No Chassis :  ' + chassis)
            {
            }
            column(Type_______Type; 'Type :  ' + Type)
            {
            }
            column(Dernier_Index__________DernierIndex; 'Dernier Index :     ' + DernierIndex)
            {
            }
            column(Sales_Header__Job_No__; "Job No.")
            {
            }
            column(DEMANDE_D_APPROVISIONNEMENTCaption; DEMANDE_D_APPROVISIONNEMENTCaptionLbl)
            {
            }
            column(Agent_Saisie__Caption; Agent_Saisie__CaptionLbl)
            {
            }
            column(Affectation__Caption; Affectation__CaptionLbl)
            {
            }
            column(Demandeur_DA__Caption; Demandeur_DA__CaptionLbl)
            {
            }
            column("Véhicule__Caption"; Véhicule__CaptionLbl)
            {
            }
            column(Date_DA__Caption; Date_DA__CaptionLbl)
            {
            }
            column(Demarcheur__Caption; Demarcheur__CaptionLbl)
            {
            }
            column("Numéro_DA__Caption"; Numéro_DA__CaptionLbl)
            {
            }
            column(N__affaire__Caption; N__affaire__CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }

            column(Sales_Header__Observation; "Purchase Request".Observation)
            {
            }
            column(TxtApprobation; TxtApprobation)
            {
            }
            column(Observation__Caption; Observation__CaptionLbl)
            {
            }
            column(Chef_DirectCaption; Chef_DirectCaptionLbl)
            {
            }
            column(Agent_De_Saisie___DemandeurCaption; Agent_De_Saisie___DemandeurCaptionLbl)
            {
            }
            column(ResponsableCaption; ResponsableCaptionLbl)
            {
            }

            dataitem("Purchase request Line"; "Purchase request Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Statut = filter(<> refused));
                CalcFields = "Location inventory In Progress";

                column(Sales_Line__No__; "No.")
                {
                }
                column(StockMagasin; "Location inventory In Progress")
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line_Quantity; Format(Quantity) + ' ' + "Unit of Measure")
                {
                }
                column(Description________Description_2_; Description + ' ' + "Description 2")
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column("Référence_ArticleCaption"; Référence_ArticleCaptionLbl)
                {
                }
                column("DésignationCaption"; DésignationCaptionLbl)
                {
                }
                column("Quantité_DACaption"; Quantité_DACaptionLbl)
                {
                }
                column(Sales_Line__Unit_of_Measure_Caption; FieldCaption("Unit of Measure"))
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }


            }
            //HS
            dataitem(Loop; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 8));
                column(Number;
                Number)
                { }
                trigger OnPreDataItem()
                var
                    rep: Report "Sales - Shipment";
                    inb: Integer;
                begin
                    inb := Loop.Count - "Purchase request Line".Count;
                    //   Message(Format("Purchase request Line".Count));
                    //  Message(Format(Loop.Count));
                    Reset();
                    SetRange(Number, 1, inb);
                    /*  if "Purchase request Line".Count > 30 then begin
                          inb := Loop.Count + "Purchase request Line".Count;
                          Reset();
                          SetRange(Number, 1, inb);
                      end;*/

                end;
            }
            //HS
            /* dataitem(SAUT; "Integer")
             {

                 column(Sales_Header__Observation; "Purchase Request".Observation)
                 {
                 }
                 column(TxtApprobation; TxtApprobation)
                 {
                 }
                 column(Observation__Caption; Observation__CaptionLbl)
                 {
                 }
                 column(Chef_DirectCaption; Chef_DirectCaptionLbl)
                 {
                 }
                 column(Agent_De_Saisie___DemandeurCaption; Agent_De_Saisie___DemandeurCaptionLbl)
                 {
                 }
                 column(ResponsableCaption; ResponsableCaptionLbl)
                 {
                 }
                 column(SAUT_Number; Number)
                 {
                 }
             }*/

            trigger OnAfterGetRecord()
            begin

                if RecUser.Get("User ID") then;
                if RecUserSetup.Get("User ID") then;
                Clear(Choix);
                case "Request Type" of
                    0:
                        Choix[1] := 'X';
                    1:
                        Choix[2] := 'X';
                    2:
                        Choix[3] := 'X';
                    3:
                        Choix[4] := 'X';
                end;

                if RecEngin.Get("Purchase Request".Engin) then;
                Desing := RecEngin."Désignation";
                immatr := RecEngin.Immatriculation;
                chassis := RecEngin."Num Châssis";
                marque := RecEngin.Marque;
                Type := RecEngin.Type;
                DernierIndex := Format(RecEngin."Compteur Actuel");
                TxtApprobation := '';
                if Approve then begin
                    if "Purchase Request".approver <> '' then
                        TxtApprobation := 'Approber par Mr : ' + "Purchase Request".approver
                    else
                        TxtApprobation := '';
                end;
            end;

            trigger OnPreDataItem()
            var
            begin
                if RecCompInf.get() then
                    RecCompInf.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var

        RecCompInf: Record "Company Information";
        RecUser: Record "User Setup";
        RecUserSetup: Record "User Setup";
        Choix: array[4] of Code[2];
        IntCompteur: Integer;
        ShippingAgent: Record "Shipping Agent";
        PageConst: label 'Page';
        RecEngin: Record "Véhicule";
        Desing: Text[100];
        immatr: Text[30];
        chassis: Text[30];
        marque: Text[30];
        type: Text[30];
        TxtApprobation: Text[100];
        DernierIndex: Text[30];
        DEMANDE_D_APPROVISIONNEMENTCaptionLbl: label 'DEMANDE D''APPROVISIONNEMENT';
        Agent_Saisie__CaptionLbl: label 'Agent Saisie :';
        Affectation__CaptionLbl: label 'Affectation :';
        Demandeur_DA__CaptionLbl: label 'Demandeur DA :';
        "Véhicule__CaptionLbl": label 'Véhicule :';
        Date_DA__CaptionLbl: label 'Date DA :';
        Demarcheur__CaptionLbl: label 'Demarcheur :';
        "Numéro_DA__CaptionLbl": label 'Numéro DA :';
        N__affaire__CaptionLbl: label 'N° affaire :';
        "Référence_ArticleCaptionLbl": label 'Référence Article';
        "DésignationCaptionLbl": label 'Désignation';
        "Quantité_DACaptionLbl": label 'Quantité DA';
        Observation__CaptionLbl: label 'Observation :';
        Chef_DirectCaptionLbl: label 'Chef Direct';
        Agent_De_Saisie___DemandeurCaptionLbl: label 'Agent De Saisie / Demandeur';
        ResponsableCaptionLbl: label 'Responsable';
}

