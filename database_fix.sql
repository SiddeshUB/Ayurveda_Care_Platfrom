-- Fix for user_enquiries table: Rename 'condition' column to 'medical_condition'
-- Run this SQL script if your database has a column named 'condition' instead of 'medical_condition'

ALTER TABLE user_enquiries 
CHANGE COLUMN `condition` `medical_condition` TEXT;

