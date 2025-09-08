-- Allow authenticated users to upload files to the 'recipe_images' bucket
CREATE POLICY "Allow authenticated recipe uploads"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'recipe_images' AND auth.uid() IS NOT NULL);


-- Public Access Policy for Recipe Images
-- Allow public access to read files from the 'recipe_images' bucket
CREATE POLICY "Allow public recipe access"
ON storage.objects FOR SELECT
USING (bucket_id = 'recipe_images');

-- Allow authenticated users to upload files to the 'recipe_images' bucket
CREATE POLICY "Allow authenticated recipe uploads"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'recipe_images'::text AND auth.uid() IS NOT NULL);


-- Recipe Category Addition
ALTER TABLE public.recipes ADD COLUMN category VARCHAR(255);

ALTER TABLE public.recipes
ADD COLUMN cooking_time VARCHAR(50),
ADD COLUMN serving_size VARCHAR(50),
ADD COLUMN short_description TEXT;


ALTER TABLE public.recipes
ADD COLUMN ingredients JSONB,
ADD COLUMN directions JSONB;

ALTER TABLE public.recipes
RENAME COLUMN author_id TO user_id;


DROP POLICY IF EXISTS "Users can update their own recipes." ON public.recipes;
DROP POLICY IF EXISTS "Users can delete their own recipes." ON public.recipes;

-- Recreate policies
CREATE POLICY "Users can update their own recipes."
ON public.recipes
FOR UPDATE
USING ((auth.uid() = user_id));

CREATE POLICY "Users can delete their own recipes."
ON public.recipes
FOR DELETE
USING ((auth.uid() = user_id));




-- Add Article URL Column
ALTER TABLE public.blog_posts
ADD COLUMN article_url VARCHAR(255);


--
