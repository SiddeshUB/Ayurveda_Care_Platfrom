-- SQL Script to fix database for vendor-based product management
-- Run this script in MySQL Workbench, phpMyAdmin, or any MySQL client

-- ========== FIX PRODUCTS TABLE ==========
-- Step 1: Drop the foreign key constraint on hospital_id
ALTER TABLE products DROP FOREIGN KEY FK57h9nf5rw5edwfodku39iy9dv;

-- Step 2: Make hospital_id column nullable
ALTER TABLE products MODIFY hospital_id BIGINT NULL;

-- ========== FIX PRODUCT_ORDERS TABLE ==========
-- Fix payment_status column to support all enum values
ALTER TABLE product_orders MODIFY payment_status VARCHAR(50);

-- Fix status column if needed
ALTER TABLE product_orders MODIFY status VARCHAR(50);

-- Fix payment_method column if needed
ALTER TABLE product_orders MODIFY payment_method VARCHAR(50);

-- ========== FIX ORDER_ITEMS TABLE ==========
-- Make vendor_id nullable for existing records
ALTER TABLE order_items MODIFY vendor_id BIGINT NULL;

-- Done! Database is now ready for the vendor product module.

