report 50051 "Suivi DA-CMD"
{ //dans nav 50050
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviDACMD.rdlc';
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Suivi DA-CMD';


    dataset
    {
        dataitem("Purchase Request"; "Purchase Request")
        {

            DataItemTableView = SORTING(/*"Order Type",*/ "Document Type", "No.")
                                 //GL2024   WHERE("Document Type" = FILTER(Order),
                                 WHERE("Document Type" = FILTER("Quote"),
                                      //GL2024 "Order Type" = CONST("Supply Order"),

                                      Statut = FILTER(<> Archive));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Posting Date", Engin;
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Job_No__; "Job No.")
            {
            }
            column(Sales_Header__Description_Engin_; "Description Engin")
            {
            }
            column(Sales_Header_Engin; Engin)
            {
            }
            column(Sales_Header__Requester_ID_; "Requester ID")
            {
            }
            column(Sales_Header__Order_Date_; "Order Date")
            {
            }
            column(DA_NCaption; DA_NCaptionLbl)
            {
            }
            column(Sales_Header__Job_No__Caption; FIELDCAPTION("Job No."))
            {
            }
            column(EnginsCaption; EnginsCaptionLbl)
            {
            }
            column(DemandeurCaption; DemandeurCaptionLbl)
            {
            }
            column(Sales_Header__Order_Date_Caption; FIELDCAPTION("Order Date"))
            {
            }
            column(QuantitCaption; QuantitCaptionLbl)
            {
            }
            column(Quantit__Re_ueCaption; Quantit__Re_ueCaptionLbl)
            {
            }
            column(Quantit__RestanteCaption; Quantit__RestanteCaptionLbl)
            {
            }
            column(affaire; affaire)
            {

            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Purchase request Line"; "Purchase request Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Sales_Line__No__; "No.")
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line_Quantity; Quantity)

                {
                    DecimalPlaces = 3 : 3;
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
            dataitem("Purchase Header"; 38)
            {
                DataItemLink = "N° Demande d'achat" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = CONST(Order));
                column(Purchase_Header__No__; "No.")
                {
                }
                column(Purchase_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Purchase_Header__Pay_to_Name_; "Pay-to Name")
                {
                }
                column(Commande_NCaption; Commande_NCaptionLbl)
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(N__Demande_d_achat; "N° Demande d'achat")
                {

                }
                dataitem("Purchase Line"; 39)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No.");
                    DataItemTableView = WHERE(Type = CONST(Item));
                    column(Purchase_Line__No__; "No.")
                    {
                    }
                    column(Purchase_Line_Description; Description)
                    {
                    }
                    column(Purchase_Line__Location_Code_; "Location Code")
                    {
                    }
                    column(Purchase_Line_Quantity; Quantity)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Purchase_Line__Quantity_Received_; "Quantity Received")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Purchase_Line__Outstanding_Quantity_; "Outstanding Quantity")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Purchase_Line_Document_Type; "Document Type")
                    {
                    }
                    column(Purchase_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Purchase_Line_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                    end;
                }
                dataitem("Purch. Rcpt. Header"; 120)
                {
                    DataItemLink = "Order No." = FIELD("No.");
                    DataItemTableView = SORTING("Order No.");
                    column(Purch__Rcpt__Header_No_; "No.")
                    {
                    }
                    column(Purch__Rcpt__Header_Order_No_; "Order No.")
                    {
                    }
                    dataitem("Purch. Rcpt. Line"; 121)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE(Quantity = FILTER(<> 0),
                                                  Type = FILTER(<> "G/L Account"));
                        column(Purch__Rcpt__Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 3 : 3;
                        }
                        column(Purch__Rcpt__Line__Posting_Date_; "Posting Date")
                        {
                        }
                        column(Purch__Rcpt__Line__No__; "No.")
                        {
                        }
                        column(Purch__Rcpt__Line_Description; Description)
                        {
                        }
                        column(Deja_Re_uCaption; Deja_Re_uCaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purch__Rcpt__Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPreDataItem()
            begin
                IF CdeDemandeur <> '' THEN SETRANGE("Requester ID", CdeDemandeur);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Demandeur"; CdeDemandeur)
                    {
                        Caption = 'Demandeur';
                        TableRelation = Demandeur;
                    }

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        CdeDemandeur: Code[20];
        "// RB SORO EXPORT EXCEL": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Text001: Label 'Données';
        Text002: Label 'Etat Suivi DA-CMD';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        DA_NCaptionLbl: Label 'DA N°';
        EnginsCaptionLbl: Label 'Engins';
        DemandeurCaptionLbl: Label 'Demandeur';
        QuantitCaptionLbl: Label 'Quantité';
        Quantit__Re_ueCaptionLbl: Label 'Quantit  Reçue';
        Quantit__RestanteCaptionLbl: Label 'Quantit  Restante';
        Commande_NCaptionLbl: Label 'Commande N°';
        Deja_Re_uCaptionLbl: Label 'Déja Reçu';
        affaire: Label 'N° affaire';

}

