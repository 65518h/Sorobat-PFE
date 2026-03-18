Table 8001420 Bitmap
{
    Caption = 'Bitmap';
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; "Classic Bitmap"; Blob)
        {
            Caption = 'Classic Bitmap';
            SubType = Bitmap;
        }
        field(3; "RoleTailored Bitmap"; Blob)
        {
            Caption = 'Roletailored Bitmap';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure fGetBitmap(pID: Integer; pIndexBlob: Integer; var pTempBitmapBuffer: Record "Bitmap Buffer" temporary)
    var
        lInStream: InStream;
        lOutStream: OutStream;
    begin
        if (Rec.Get(pID)) then begin
            if ((not Rec."Classic Bitmap".Hasvalue) and (not Rec."RoleTailored Bitmap".Hasvalue)) then begin
                Rec.Get(0);
                Rec.CalcFields("Classic Bitmap");
                pTempBitmapBuffer.Init();
                pTempBitmapBuffer."Primary Key" := pIndexBlob;
                pTempBitmapBuffer.Bitmap := Rec."Classic Bitmap";
                pTempBitmapBuffer.Insert();
            end else begin
                pTempBitmapBuffer.Init();
                pTempBitmapBuffer."Primary Key" := pIndexBlob;
                if (ISSERVICETIER) then begin
                    if (Rec."RoleTailored Bitmap".Hasvalue) then begin
                        Rec.CalcFields("RoleTailored Bitmap");
                        pTempBitmapBuffer.Bitmap := Rec."RoleTailored Bitmap";
                    end else begin
                        Rec.CalcFields("Classic Bitmap");
                        pTempBitmapBuffer.Bitmap := Rec."Classic Bitmap";
                    end;
                end else begin
                    if (Rec."Classic Bitmap".Hasvalue) then begin
                        Rec.CalcFields("Classic Bitmap");
                        pTempBitmapBuffer.Bitmap := Rec."Classic Bitmap";
                    end else begin
                        Rec.CalcFields("RoleTailored Bitmap");
                        pTempBitmapBuffer.Bitmap := Rec."RoleTailored Bitmap";
                    end;
                end;
                pTempBitmapBuffer.Insert(false);
            end;
        end else begin
            Rec.Get(0);
            Rec.CalcFields("Classic Bitmap");
            pTempBitmapBuffer.Init();
            pTempBitmapBuffer."Primary Key" := pIndexBlob;
            pTempBitmapBuffer.Bitmap := Rec."Classic Bitmap";
            pTempBitmapBuffer.Insert(false);
        end;
    end;


    procedure fImportBitmap(pServiceTier: Boolean) retour: Text[30]
    var
        lFileName: Text[255];
        l3tierMngt: Codeunit "File Management";
    // lTmpBlob: Record 99008535 temporary;
    begin
        //DYS A VERIFIER
        // lFileName := l3tierMngt.BLOBImport(lTmpBlob, '*.BMP', true);
        // if lFileName = '' then
        //     exit;

        // if (pServiceTier) then
        //     Rec."RoleTailored Bitmap" := lTmpBlob.Blob
        // else
        //     Rec."Classic Bitmap" := lTmpBlob.Blob
    end;


    procedure fExportBitmap(pServicetier: Boolean)
    var
        l3TierMngt: Codeunit "File Management";
        // lTmpBlobRef: Record 99008535 temporary;
        lFileName: Text[1024];

    begin
        Rec.CalcFields("Classic Bitmap", "RoleTailored Bitmap");
        //DYS A VERIFIER
        // if (pServicetier) and ("RoleTailored Bitmap".Hasvalue) then begin
        //     lTmpBlobRef.Blob := "RoleTailored Bitmap";
        //     l3TierMngt.BLOBExport(lTmpBlobRef, lFileName, true);
        // end;
        // if (not pServicetier) and ("Classic Bitmap".Hasvalue) then begin
        //     lTmpBlobRef.Blob := "Classic Bitmap";
        //     l3TierMngt.BLOBExport(lTmpBlobRef, lFileName, true);
        // end;
    end;
}

