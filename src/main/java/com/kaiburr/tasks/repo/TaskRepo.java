


package com.kaiburr.tasks.repo;

import com.kaiburr.tasks.Task;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface TaskRepo extends MongoRepository<Task, String> {
    List<Task> findByNameContainingIgnoreCase(String name);
}
