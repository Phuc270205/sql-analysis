-- cleaning the data


Select *
From SQL_Project.dbo.NashvilleHousing


-- Standardize Date Format 

Select SaleDateConverted, CONVERT(Date, SaleDate)
From SQL_Project.dbo.NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


-- Populate Property Address data

Select *
From SQL_Project.dbo.NashvilleHousing
order by ParcelID

--

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,  b.PropertyAddress)
From SQL_Project.dbo.NashvilleHousing a
JOIN SQL_Project.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,  b.PropertyAddress)
From SQL_Project.dbo.NashvilleHousing a
JOIN SQL_Project.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID]
Where a.PropertyAddress is null

--------------------------------

-- Seperate the Adress into individual columns (Adrress, City, State)

Select PropertyAddress
From SQL_Project.dbo.NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

From SQL_Project.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddess Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddess = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


Select *
From SQL_Project.dbo.NashvilleHousing


--

Select OwnerAddress
From SQL_Project.dbo.NashvilleHousing



Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
From SQL_Project.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


Select *
From SQL_Project.dbo.NashvilleHousing


-----------------------------

-- Change 1 and 0 to YES and NO in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From SQL_Project.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2



SELECT 
    CASE 
        WHEN SoldAsVacant = 1 THEN 'Yes'
        WHEN SoldAsVacant = 0 THEN 'No'
    END AS SoldAsVacant,
    COUNT(*) AS Total
FROM SQL_Project.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY Total;


ALTER TABLE SQL_Project.dbo.NashvilleHousing
ADD NewSoldAsVacant VARCHAR(3);

UPDATE SQL_Project.dbo.NashvilleHousing
SET NewSoldAsVacant = CASE
    WHEN SoldAsVacant = 1 THEN 'Yes'
    WHEN SoldAsVacant = 0 THEN 'No'
END;
-----------------------------

-- Remove Duplicates


WITH RowNumCTE AS(
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY ParcelID,
                        PropertyAddress,
                        SalePrice,
                        SaleDate,
                        LegalReference
           ORDER BY UniqueID
       ) AS row_num
FROM SQL_Project.dbo.NashvilleHousing
)
DELETE
From RowNumCTE
Where row_num > 1



-----------------------------


-- Delete Unused Columns


Select *
From SQL_Project.dbo.NashvilleHousing


ALTER TABLE SQL_Project.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

