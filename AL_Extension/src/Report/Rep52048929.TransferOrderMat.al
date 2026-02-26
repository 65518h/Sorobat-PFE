namespace Microsoft.Inventory.Transfer;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using System.Utilities;

report 52048929 "Transfer Order Mat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer Order Mat.rdl';
    Caption = 'Transfer Order';
    WordMergeDataItem = "Transfer Header";

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';

            column(Date_Saisie; "Date Saisie")
            {

            }
            column(Observation; Observation)
            {

            }
            column(User_ID; "Assigned User ID")
            {

            }
            column(ReceptioneurName; salarier."Nom Et Prenom")
            {

            }

            column(Shipment_Date; "Shipment Date") { }
            column("TransferfromCode"; "Transfer-from Code")
            {

            }
            column("TransfertoCode"; "Transfer-to Code")
            {

            }
            column(Last_Shipment_No_; "Last Shipment No.")
            {

            }
            column(Picture; CompanyInfo.Picture) { }
            column(CompanyAdrersse; CompanyInfo.Address)
            {

            }
            column(CompanyPosteCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyVatRegistration; CompanyInfo."vat Registration No.")
            {
            }
            column(No_TransferHdr; "No.")
            {
            }
            column(TransferOrderNoCaption; TransferOrderNoCaptionLbl)
            {
            }
            column(CopyCaption; StrSubstNo(Text001, CopyText))
            {
            }
            column(TransferToAddr1; TransferToAddr[1])
            {
            }
            column(TransferFromAddr1; TransferFromAddr[1])
            {
            }
            column(TransferToAddr2; TransferToAddr[2])
            {
            }
            column(TransferFromAddr2; TransferFromAddr[2])
            {
            }
            column(TransferToAddr3; TransferToAddr[3])
            {
            }
            column(TransferFromAddr3; TransferFromAddr[3])
            {
            }
            column(TransferToAddr4; TransferToAddr[4])
            {
            }
            column(TransferFromAddr4; TransferFromAddr[4])
            {
            }
            column(TransferToAddr5; TransferToAddr[5])
            {
            }
            column(TransferToAddr6; TransferToAddr[6])
            {
            }
            column(InTransitCode_TransHdr; "Transfer Header"."In-Transit Code")
            {
                IncludeCaption = true;
            }
            column(PostingDate_TransHdr; Format("Transfer Header"."Posting Date", 0, 4))
            {
            }
            column(TransferToAddr7; TransferToAddr[7])
            {
            }
            column(TransferToAddr8; TransferToAddr[8])
            {
            }
            column(TransferFromAddr5; TransferFromAddr[5])
            {
            }
            column(TransferFromAddr6; TransferFromAddr[6])
            {
            }
            column(PageCaption; StrSubstNo(Text002, ''))
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(ShptMethodDesc; ShipmentMethod.Description)
            {
            }
            /*   dataitem(CopyLoop; "Integer")
               {
                   DataItemTableView = sorting(Number);*/
            /*   dataitem(PageLoop; "Integer")
               {
                   DataItemTableView = sorting(Number) where(Number = const(1));*/

            /*   dataitem(DimensionLoop1; "Integer")
               {
                   DataItemLinkReference = "Transfer Header";
                   DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                   column(DimText; DimText)
                   {
                   }
                   column(Number_DimensionLoop1; Number)
                   {
                   }
                   column(HdrDimensionsCaption; HdrDimensionsCaptionLbl)
                   {
                   }

                   trigger OnAfterGetRecord()
                   begin
                       if Number = 1 then begin
                           if not DimSetEntry1.FindSet() then
                               CurrReport.Break();
                       end else
                           if not Continue then
                               CurrReport.Break();

                       Clear(DimText);
                       Continue := false;
                       repeat
                           OldDimText := DimText;
                           if DimText = '' then
                               DimText := StrSubstNo('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                           else
                               DimText :=
                                 StrSubstNo(
                                   '%1; %2 - %3', DimText,
                                   DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                           if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                               DimText := OldDimText;
                               Continue := true;
                               exit;
                           end;
                       until DimSetEntry1.Next() = 0;
                   end;

                   trigger OnPreDataItem()
                   begin
                       if not ShowInternalInfo then
                           CurrReport.Break();
                   end;
               }*/
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Transfer Header";
                DataItemTableView = sorting("Document No.", "Line No.") where("Derived From Line No." = const(0));
                column(RecItemCost; RecItem."Unit Cost")
                {
                }
                column(TotQteunitPrice; TotQteunitPrice)
                {

                }
                column(VehiculeDésignation; Vehicule."Désignation") { }
                column(ItemNo_TransLine; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_TransLine; Description)
                {
                    IncludeCaption = true;
                }
                column(Qty_TransLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UOM_TransLine; "Unit of Measure")
                {
                    IncludeCaption = true;
                }
                column(Qty_TransLineShipped; "Quantity Shipped")
                {
                    IncludeCaption = true;
                }
                column(QtyReceived_TransLine; "Quantity Received")
                {
                    IncludeCaption = true;
                }
                column(TransFromBinCode_TransLine; "Transfer-from Bin Code")
                {
                    IncludeCaption = true;
                }
                column(TransToBinCode_TransLine; "Transfer-To Bin Code")
                {
                    IncludeCaption = true;
                }
                column(LineNo_TransLine; "Line No.")
                {
                }
                column(TotQte; TotQte)
                {
                }
                column(TotMontant; TotMontant)
                {
                }

                /*   dataitem(DimensionLoop2; "Integer")
                   {
                       DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                       column(DimText2; DimText)
                       {
                       }
                       column(Number_DimensionLoop2; Number)
                       {
                       }
                       column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                       {
                       }


                       trigger OnAfterGetRecord()
                       begin
                           if Number = 1 then begin
                               if not DimSetEntry2.FindSet() then
                                   CurrReport.Break();
                           end else
                               if not Continue then
                                   CurrReport.Break();

                           Clear(DimText);
                           Continue := false;
                           repeat
                               OldDimText := DimText;
                               if DimText = '' then
                                   DimText := StrSubstNo('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                               else
                                   DimText :=
                                     StrSubstNo(
                                       '%1; %2 - %3', DimText,
                                       DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                               if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                   DimText := OldDimText;
                                   Continue := true;
                                   exit;
                               end;
                           until DimSetEntry2.Next() = 0;
                       end;

                       trigger OnPreDataItem()
                       begin
                           if not ShowInternalInfo then
                               CurrReport.Break();
                       end;
                   }*/

                trigger OnAfterGetRecord()
                begin
                    TotQteunitPrice := 0;
                    DimSetEntry2.SetRange("Dimension Set ID", "Dimension Set ID");

                    IF Vehicule.GET("Transfer Line"."N° vehicule") THEN;
                    RecItem.GET("Transfer Line"."Item No.");
                    TotQteunitPrice := Quantity * RecItem."Unit Cost";
                    TotQte += Quantity;
                    TotMontant += Quantity * RecItem."Unit Cost";
                end;
            }


            //   }
            /*    dataitem(Loop; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 .. 7));
                    column(Number;
                    Number)
                    { }
                    trigger OnPreDataItem()
                    var

                        inb: Integer;
                    begin
                        inb := Loop.Count - "Transfer Line".Count;
                        //   Message(Format("Purchase request Line".Count));
                        //  Message(Format(Loop.Count));
                        Reset();
                        SetRange(Number, 1, inb);


                    end;
                }*/
            /*   trigger OnAfterGetRecord()
               begin
                   if Number > 1 then begin
                       CopyText := Text000;
                       OutputNo += 1;
                   end;
               end;

               trigger OnPreDataItem()
               begin
                   NoOfLoops := Abs(NoOfCopies) + 1;
                   CopyText := '';
                   SetRange(Number, 1, NoOfLoops);
                   OutputNo := 1;
                   CompanyInfo.get();
                   CompanyInfo.CalcFields(Picture);
               end;

           }*/
            trigger OnPreDataItem()
            begin

                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                if Salarier.Get("Id Receptioneur") then;
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr, "Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr, "Transfer Header");

                if not ShipmentMethod.Get("Shipment Method Code") then
                    ShipmentMethod.Init();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Location;
                        Caption = 'Nombre de copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Location;
                        Caption = 'Afficher info. internes';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
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
        PostingDateCaption = 'Posting Date';
        ShptMethodDescCaption = 'Shipment Method';
    }

    var
        Salarier: Record Salarier;
        RecItem: Record Item;
        TotQte: Decimal;
        TotQteunitPrice: Decimal;
        TotMontant: Decimal;
        Vehicule: Record "Véhicule";
        CompanyInfo: Record "Company Information";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        Continue: Boolean;

        Text000: Label 'COPIE';
        Text001: Label 'Bon de Sortie %1';
        Text002: Label 'Page %1';
        HdrDimensionsCaptionLbl: Label 'Header Dimensions';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        TransferOrderNoCaptionLbl: Label 'Transfer Order No.';

    protected var
        ShipmentMethod: Record "Shipment Method";
        FormatAddr: Codeunit "Format Address";
        TransferFromAddr: array[8] of Text[100];
        TransferToAddr: array[8] of Text[100];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        ShowInternalInfo: Boolean;
}

