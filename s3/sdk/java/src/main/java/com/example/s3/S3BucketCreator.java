package com.example.s3;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.CreateBucketConfiguration;
import software.amazon.awssdk.services.s3.model.S3Exception;
import java.util.Scanner;

public class S3BucketCreator {
    public static void main(String[] args) {
        // 1. Capture dynamic user prompt input from terminal
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a custom name for your new Java S3 bucket: ");
        String bucketName = scanner.nextLine().trim();

        if (bucketName.isEmpty()) {
            System.out.println("❌ Error: Bucket name cannot be empty.");
            scanner.close();
            return;
        }

        // 2. Initialize the S3 client using the standard AWS credential provider chain
        Region region = Region.EU_NORTH_1;
        S3Client s3 = S3Client.builder()
                .region(region)
                .build();

        System.out.println("Initiating bucket creation for: " + bucketName + "...");

        try {
            // 3. Map the location constraint configuration required for eu-north-1
            CreateBucketConfiguration bucketConfiguration = CreateBucketConfiguration.builder()
                    .locationConstraint(region.id())
                    .build();

            // 4. Build the complete request structure payload
            CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                    .bucket(bucketName)
                    .createBucketConfiguration(bucketConfiguration)
                    .build();

            // 5. Execute the bucket construction via the API client interface
            s3.createBucket(createBucketRequest);
            System.out.println("🚀 Success! S3 Bucket '" + bucketName + "' has been created natively in eu-north-1.");

        } catch (S3Exception e) {
            System.err.println("❌ AWS API Error: " + e.awsErrorDetails().errorMessage());
        } finally {
            // Clean up running operational connections and scanner pipelines cleanly
            s3.close();
            scanner.close();
        }
    }
}
